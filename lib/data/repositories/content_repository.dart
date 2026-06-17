import '../../core/network/api_exception.dart';
import '../api/curae_api.dart';
import '../models/article.dart';
import '../models/family_member.dart';
import '../models/notification.dart';
import '../models/records.dart';

/// Records, family members, articles and notifications — the read-mostly
/// content collections of the demo.
class ContentRepository {
  ContentRepository(this._api);

  final CuraeApi _api;

  Future<HealthRecords> records() async {
    try {
      return await _api.records();
    } catch (e) {
      throw ApiException.from(e);
    }
  }

  Future<List<FamilyMember>> familyMembers() async {
    try {
      return await _api.familyMembers();
    } catch (e) {
      throw ApiException.from(e);
    }
  }

  Future<FamilyMember> addFamilyMember(Map<String, dynamic> body) async {
    try {
      return await _api.createFamilyMember(body);
    } catch (e) {
      throw ApiException.from(e);
    }
  }

  Future<FamilyMember> updateFamilyMember(String id, Map<String, dynamic> body) async {
    try {
      return await _api.patchFamilyMember(id, body);
    } catch (e) {
      throw ApiException.from(e);
    }
  }

  Future<void> removeFamilyMember(String id) async {
    try {
      await _api.deleteFamilyMember(id);
    } catch (e) {
      throw ApiException.from(e);
    }
  }

  Future<List<Article>> articles() async {
    try {
      return await _api.articles();
    } catch (e) {
      throw ApiException.from(e);
    }
  }

  Future<Article> article(String id) async {
    try {
      return await _api.article(id);
    } catch (e) {
      throw ApiException.from(e);
    }
  }

  Future<List<AppNotification>> notifications() async {
    try {
      final list = await _api.notifications();
      return list;
    } catch (e) {
      throw ApiException.from(e);
    }
  }

  Future<AppNotification> markRead(String id, {bool read = true}) async {
    try {
      return await _api.patchNotification(id, {'read': read});
    } catch (e) {
      throw ApiException.from(e);
    }
  }
}
