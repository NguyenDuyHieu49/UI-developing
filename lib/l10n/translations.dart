import 'package:flutter/foundation.dart';

/// Simple in-memory translation map for a beginner-friendly localization demo.
class LocaleService {
  // holds current language code: 'en' or 'vi'
  static final ValueNotifier<String> current = ValueNotifier('en');

  static void setLocale(String code) {
    current.value = code;
  }
}

const Map<String, Map<String, String>> _translations = {
  'en': {
    'app_title': 'English Forum',
    'attach_image': 'Attach image',
    'remove': 'Remove',
    'search_hint': 'Search posts or users...',
    'no_results': 'No results',
    'home': 'Home',
    'search': 'Search',
    'daily': 'Daily',
    'alerts': 'Alerts',
    'settings': 'Settings',
    'create_post': 'Create Post',
    'whats_on_your_mind': "What's on your mind?",
    'cancel': 'Cancel',
    'post': 'Post',
    'comments': 'Comments',
    'notifications': 'Notifications',
    'daily_exercises': 'Daily Exercises',
    'profile': 'Profile',
    'login': 'Login',
    'register_prompt': 'Don\'t have an account? Register',
    'register': 'Register',
    'change_language': 'Change Language',
    'privacy_security': 'Privacy & Security',
    'logout': 'Log out',
    'language_english': 'English',
    'language_vietnamese': 'Tiếng Việt',
    'comments_title': 'Comments',
    'no_comments': 'No comments yet',
    'send': 'Send',
    'private_account': 'Private account',
    'show_last_seen': 'Show last seen',
    'privacy_policy': 'Privacy policy (placeholder)',
    'privacy_policy_title': 'Privacy policy',
    'privacy_policy_placeholder':
        'This is a placeholder privacy policy for the demo app.',
    'close': 'Close',
    'help': 'Help',
    'about': 'About',
    'are_you_sure_logout': 'Are you sure you want to log out?',
    'just_now': 'Just now',
    'private_account_subtitle':
        'When enabled, only approved followers can see your posts.',
    'create_account': 'Create Account',
    // flashcard / study strings
    'show_meaning': 'Show meaning',
    'hide': 'Hide',
    'mark_known': 'Mark known',
    'known': 'Known',
    'card': 'Card',
    'marked_known': 'marked known',
  },
  'vi': {
    'app_title': 'English Forum',
    'attach_image': 'Đính kèm hình ảnh',
    'remove': 'Xóa',
    'search_hint': 'Tìm bài viết hoặc người dùng...',
    'no_results': 'Không có kết quả',
    'home': 'Trang chủ',
    'search': 'Tìm kiếm',
    'daily': 'Hàng ngày',
    'alerts': 'Thông báo',
    'settings': 'Cài đặt',
    'create_post': 'Tạo bài viết',
    'whats_on_your_mind': 'Bạn đang nghĩ gì?',
    'cancel': 'Hủy',
    'post': 'Đăng',
    'comments': 'Bình luận',
    'notifications': 'Thông báo',
    'daily_exercises': 'Bài tập hàng ngày',
    'profile': 'Hồ sơ',
    'login': 'Đăng nhập',
    'register_prompt': 'Chưa có tài khoản? Đăng ký',
    'register': 'Đăng ký',
    'change_language': 'Thay đổi ngôn ngữ',
    'privacy_security': 'Quyền riêng tư & Bảo mật',
    'logout': 'Đăng xuất',
    'language_english': 'English',
    'language_vietnamese': 'Tiếng Việt',
    'comments_title': 'Bình luận',
    'no_comments': 'Chưa có bình luận',
    'send': 'Gửi',
    'private_account': 'Tài khoản riêng tư',
    'show_last_seen': 'Hiển thị lần truy cập cuối',
    'privacy_policy': 'Chính sách quyền riêng tư (ví dụ)',
    'privacy_policy_title': 'Chính sách quyền riêng tư',
    'privacy_policy_placeholder':
        'Đây là chính sách quyền riêng tư ví dụ cho ứng dụng demo.',
    'close': 'Đóng',
    'help': 'Trợ giúp',
    'about': 'Giới thiệu',
    'are_you_sure_logout': 'Bạn có chắc muốn đăng xuất không?',
    'just_now': 'Vừa xong',
    'private_account_subtitle':
        'Khi bật, chỉ người theo dõi được chấp nhận mới thấy bài viết của bạn.',
    'create_account': 'Tạo tài khoản',
    // flashcard / study strings
    'show_meaning': 'Hiển thị nghĩa',
    'hide': 'Ẩn',
    'mark_known': 'Đánh dấu đã thuộc',
    'known': 'Đã thuộc',
    'card': 'Thẻ',
    'marked_known': 'đã được đánh dấu là thuộc',
  },
};

String t(String key) {
  final code = LocaleService.current.value;
  return _translations[code]?[key] ?? key;
}
