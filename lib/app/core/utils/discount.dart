class Discount {
  static int getPromoDiscountAmount(
      String type, int promoDiscountValue, int servicePrice) {
    int promoDiscountAmount = 0;
    if (type == 'fixed') {
      promoDiscountAmount = promoDiscountValue;
    }
    if (type == 'percent') {
      promoDiscountAmount = (servicePrice * (promoDiscountValue) / 100).floor();
    }
    return promoDiscountAmount;
  }
}
