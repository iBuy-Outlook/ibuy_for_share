class CBPrograms {
  String retailerName; //Name of the retailer
  double spendAmount; //Monthly spend at the retailer required to avail plan
  double cashbackPCT; //%CashBack offer (on spendAmount)
  DateTime pgOfferStartDate; //date that the program becomes available to the market
  DateTime pgOfferEndDate; // date that the program is taken off the market
  DateTime pgEndDate; // pgOfferEndDate + 4 weeks
  int maxCustomers; // Max # of customers that can be recruited.
                    // The program will be taken off the market after this number is met.
  String mapRange; // are in which the plan is to be activated

  CBPrograms({
    this.retailerName,
    this.spendAmount,
    this.cashbackPCT,
    this.pgOfferStartDate,
    this.pgOfferEndDate,
    this.pgEndDate,
    this.maxCustomers,
    this.mapRange,
});

}