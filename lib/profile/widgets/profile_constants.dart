String translateAccountType(String type) {
  switch (type) {
    case 'standard': return 'عادي';
    case 'premium': return 'مميز';
    case 'admin': return 'مدير';
    default: return type;
  }
}