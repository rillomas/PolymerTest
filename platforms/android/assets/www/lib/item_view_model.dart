import 'dart:math';
import 'package:polymer/polymer.dart';

class ItemViewModel extends Observable {
	ItemViewModel(this.text);

	/// text of this item
	@observable
	String text;

	/// position and size
	Rectangle<int> rect = new Rectangle<int>(0,0,0,0);

	/// true if this item is already shown
	bool entered = false;
}