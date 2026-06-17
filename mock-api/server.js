// Curae mock REST API.
//
//   npm install         # once
//   npm start           # -> http://localhost:3000  (auth + fresh slots + resources)
//   npm run db          # plain json-server (no /auth, static slots) as a fallback
//
// Adds the auth endpoints json-server can't model on its own and regenerates
// doctor availability with fresh future dates on every request so the demo
// never shows stale calendars. Network latency / flaky errors are simulated on
// the Flutter side (Dio interceptor), so the server itself stays simple.

const jsonServer = require('json-server');
const path = require('path');

const server = jsonServer.create();
const router = jsonServer.router(path.join(__dirname, 'db.json'));
const middlewares = jsonServer.defaults();
const routes = require('./routes.json');

const TOKEN = 'mock-jwt-token-curae-demo';
const SLOT_TIMES = ['09:00', '09:30', '10:00', '10:30', '11:00', '14:00',
  '14:30', '15:00', '15:30', '16:00', '16:30', '17:00'];

function isoDate(d) {
  return d.toISOString().slice(0, 10);
}

function safeUser(user) {
  if (!user) return null;
  const { password, ...rest } = user;
  return rest;
}

function freshSlots(doctorId, days = 14) {
  const seed = parseInt(String(doctorId).replace(/\D/g, ''), 10) || 1;
  const out = [];
  const today = new Date();
  for (let offset = 1; offset <= days; offset++) {
    const day = new Date(today);
    day.setDate(today.getDate() + offset);
    if (day.getDay() === 0) continue; // closed Sundays
    const slots = SLOT_TIMES.filter((_, j) => (seed + offset + j) % 3 !== 0);
    if (slots.length === 0) continue;
    out.push({ id: `slot_${doctorId}_${offset}`, doctorId, date: isoDate(day), slots });
  }
  return out;
}

server.use(middlewares);
server.use(jsonServer.bodyParser);

// --- auth -------------------------------------------------------------------
server.post('/auth/login', (req, res) => {
  const { email } = req.body || {};
  const users = router.db.get('users').value();
  const user =
    users.find((u) => u.email.toLowerCase() === String(email || '').toLowerCase()) || users[0];
  res.jsonp({ token: TOKEN, user: safeUser(user) });
});

server.post('/auth/register', (req, res) => {
  const base = router.db.get('users').value()[0];
  const body = req.body || {};
  const user = { ...base, ...body, id: base.id };
  res.status(201).jsonp({ token: TOKEN, user: safeUser(user) });
});

server.get('/auth/me', (req, res) => {
  const user = router.db.get('users').value()[0];
  res.jsonp({ user: safeUser(user) });
});

// --- fresh availability (overrides static db slots) -------------------------
server.get('/doctors/:id/slots', (req, res) => {
  let data = freshSlots(req.params.id);
  if (req.query.date) data = data.filter((s) => s.date === req.query.date);
  res.jsonp(data);
});

// never leak password through the users collection
router.render = (req, res) => {
  let data = res.locals.data;
  if (Array.isArray(data)) {
    data = data.map((x) => (x && x.password ? safeUser(x) : x));
  } else if (data && data.password) {
    data = safeUser(data);
  }
  res.jsonp(data);
};

server.use(jsonServer.rewriter(routes));
server.use(router);

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
  console.log(`Curae mock API running on http://localhost:${PORT}`);
});
