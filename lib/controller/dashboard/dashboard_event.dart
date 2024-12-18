abstract class HomePageEvent {
  const HomePageEvent();
}

class gotoDiscover extends HomePageEvent {
  const gotoDiscover();
}

class gotoCart extends HomePageEvent {
  const gotoCart();
}

class gotoSell extends HomePageEvent {
  const gotoSell();
}

class OnScrollEvent extends HomePageEvent {
  final int index;

  const OnScrollEvent(this.index);
}

class gotoInbox extends HomePageEvent {
  const gotoInbox();
}

class gotoProfile extends HomePageEvent {
  const gotoProfile();
}
