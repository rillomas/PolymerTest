import 'dart:html';
import 'dart:js';
import 'package:polymer/polymer.dart';
import 'package:chrome/chrome_app.dart' as chrome;
import 'item_view_model.dart';
import 'custom-list.dart';

@CustomTag("main-app")
class MainApp extends PolymerElement {
	MainApp.created() : super.created() {
		itemList = toObservable([
			new ItemViewModel("aardvark"),
			new ItemViewModel("binturong"),
			new ItemViewModel("caribou"),
			new ItemViewModel("dingo"),
			new ItemViewModel("elephant"),
		]);
	}

	@observable
	List itemList = [];

	@observable
	int bounceBackNum = 5;

	@observable
	bool canIncrement = true;

	@observable
	bool canDecrement = true;

	@observable
	String text = "";

	void bounceBackNumChanged(int oldValue) {
		canIncrement = (bounceBackNum < CustomList.MAX_BOUNCEBACK);
		canDecrement = (bounceBackNum > CustomList.MIN_BOUNCEBACK);
	}

	void addItem(Event e, var detail, Node target) {
		itemList.add(new ItemViewModel(text));
	}

	void clearItems(Event e, var detail, Node target) {
		itemList.clear();
	}

	void incrementBounceBack(Event e, var detail, Node target) {
		bounceBackNum++;
		resetLayout();
	}

	void decrementBounceBack(Event e, var detail, Node target) {
		bounceBackNum--;
		resetLayout();
	}
	
	void notify(Event e, var detail, Node target) {
		var id = "notifyId";
		var option = new chrome.NotificationOptions(
			type: chrome.TemplateType.BASIC,
			iconUrl: "icons/icon16.png",
			title: "Sample Notification",
			message: "Sample message"
		);

		chrome.notifications.create(id, option).then((msg) {
			print(msg);
		});

		  // var id = "notifyId";
		  // var func = new JsFunction.withThis((str) {
		  // 	print(str);
		  // });
		  // var notifyOption = new JsObject.jsify({
		  // 	"type": "basic",
		  // 	"iconUrl": "http://upload.wikimedia.org/wikipedia/commons/8/87/Google_Chrome_icon_%282011%29.png",
		  // 	"title": "Sample Notification",
		  // 	"message": "Sample message",
		  // });
		  // print(chrome);
		  // var notifications = chrome["notifications"];
		  // print(notifications);
		  // var runtime = chrome["runtime"];
		  // print(runtime);
		  // notifications.callMethod('create', [id, notifyOption, func]);
	}

	void resetLayout() {
		var list = [];
		for (var item in itemList) {
			list.add(new ItemViewModel(item.text));
		}
		itemList = toObservable(list);
	}
}
