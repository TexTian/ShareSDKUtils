package util
{
	import cn.sharesdk.ane.PlatformID;
	import cn.sharesdk.ane.ShareSDKExtension;
	import cn.sharesdk.ane.ShareType;
	
	import lzm.util.Mobile;

	public class ShareSDKUtil
	{
		
		/**
		 * 微信(IOS下用代码中的id)
		 * */
		private const wxAppId:String = "wx7d56b50a9cd80224";
		/**
		 * 新浪微博(IOS下用代码中的id)
		 * */
		private const sina_appkey:String = "368034068";
		private const sina_appsecret:String = "f90230d965d57a7d2fd365cef4345151";
		private const sina_redirecturi:String = "http://www.cmge.com";
		
		private static var _instance:ShareSDKUtil;
		private var shareSDK:ShareSDKExtension;
		private var _completeFunc:Function;
		private var isIOS:Boolean;
		public function ShareSDKUtil()
		{
			if(_instance)throw new Error("shareSDK should be singleton");
			_instance = this;
		}
		public static function Instance():ShareSDKUtil
		{
			if(_instance==null)
				_instance = new ShareSDKUtil();
			return _instance;
		}
		public function initShareSDK(ssid:String,onComplete:Function, onError:Function, onCancel:Function):void
		{
			shareSDK = new ShareSDKExtension();
			shareSDK.open(ssid);
			isIOS = Mobile.isIOS();
			//如果是IOS就要通过代码配置 如果是安卓就通过ShareSDK.xml配置
			if(isIOS)
			{
				var wechatConf:Object = new Object();
				wechatConf["app_id"] = wxAppId;
				
				var sinaweiboConf:Object = new Object();
				sinaweiboConf["app_key"] = sina_appkey;
				sinaweiboConf["app_secret"] = sina_appsecret;
				sinaweiboConf["redirect_uri"] = sina_redirecturi;
				
				shareSDK.setPlatformConfig(PlatformID.WeChatSession, wechatConf);
				shareSDK.setPlatformConfig(PlatformID.WeChatTimeline, wechatConf);
				shareSDK.setPlatformConfig(PlatformID.SinaWeibo, sinaweiboConf);
			}
			shareSDK.setPlatformActionListener(onComplete, onError, onCancel);
		}
		public function showToast(str:String):void
		{
			shareSDK.toast(str);
		}
		/**
		 * 直接分享内容到朋友圈(微信朋友圈)
		 * 这种情况下将不显示text里面的内容
		 * */
		public function shareWebpageNoMenuToWxFriend(title:String, titleUrl:String, text:String, imageUrl:String):void
		{
			var shareParams:Object = new Object();
			shareParams.type = ShareType.SHARE_WEBPAGE;
			shareParams.title = title;
			if(isIOS)
			{
				shareParams.titleUrl = titleUrl;
				shareParams.imageUrl = imageUrl;				
			}else{
				shareParams.url = titleUrl;
				shareParams.imagePath = imageUrl;			
			}
			shareParams.text = text;
			shareSDK.showShareView(PlatformID.WeChatTimeline, shareParams);
		}
		/**
		 * 直接分享大图到朋友圈(微信朋友圈)
		 * */
		public function shareImageNoMenuToWxFriend(imageUrl:String):void
		{
			var shareParams:Object = new Object();
			shareParams.type = ShareType.SHARE_IMAGE;
			if(isIOS)
				shareParams.imageUrl = imageUrl;
			else
				shareParams.imagePath = imageUrl;
			shareSDK.showShareView(PlatformID.WeChatTimeline, shareParams);
		}
		/**
		 * 直接分享内容到微信好友(微信)
		 * */
		public function shareWebpageNoMenuToWx(title:String, titleUrl:String, text:String, imageUrl:String):void
		{
			var shareParams:Object = new Object();
			shareParams.type = ShareType.SHARE_WEBPAGE;
			shareParams.title = title;
			if(isIOS)
			{
				shareParams.titleUrl = titleUrl;
				shareParams.imageUrl = imageUrl;				
			}else{
				shareParams.url = titleUrl;
				shareParams.imagePath = imageUrl;			
			}
			shareParams.text = text;
			shareSDK.showShareView(PlatformID.WeChatSession, shareParams);
		}
		/**
		 * 直接分享大图到微信好友(微信)
		 * */
		public function shareImageNoMenuToWx(imageUrl:String):void
		{
			var shareParams:Object = new Object();
			shareParams.type = ShareType.SHARE_IMAGE;
			if(isIOS)
				shareParams.imageUrl = imageUrl;
			else
				shareParams.imagePath = imageUrl;
			shareSDK.showShareView(PlatformID.WeChatSession, shareParams);
		}
		/**
		 * 可选分享目标的大图分享（微信和微信朋友圈）
		 * */
		public function shareImageWithMenu(imageUrl:String):void
		{
			var shareParams:Object = new Object();
			shareParams.type = ShareType.SHARE_IMAGE;
			if(isIOS)
				shareParams.imageUrl = imageUrl;
			else
				shareParams.imagePath = imageUrl;
			shareSDK.showShareMenu(null, shareParams);
		}
		/**
		 * 可选分享目标的内容分享(微信和微信朋友圈)
		 * */
		public function shareWebpageWithMenu(title:String, titleUrl:String, text:String, imageUrl:String):void
		{
			var shareParams:Object = new Object();
			shareParams.type = ShareType.SHARE_WEBPAGE;
			shareParams.title = title;
			if(isIOS)
			{
				shareParams.titleUrl = titleUrl;
				shareParams.imageUrl = imageUrl;				
			}else{
				shareParams.url = titleUrl;
				shareParams.imagePath = imageUrl;			
			}
			shareParams.text = text;
			shareSDK.showShareMenu(null, shareParams);
		}
		/**
		 * 直接分享到新浪微博
		 * */
		public function shareContentNoMenuToSina(text:String, imageUrl:String=null):void
		{
			var shareParams:Object = new Object();
			shareParams.type = ShareType.SHARE_WEBPAGE;
			if(imageUrl)
			{
				if(isIOS)				
					shareParams.imageUrl = imageUrl;
				else
					shareParams.imagePath = imageUrl;
			}
			shareParams.text = text;
			shareSDK.showShareView(PlatformID.SinaWeibo, shareParams);
		}
		public function shareAppsNoMenu(title:String, titleUrl:String, text:String, imageUrl:String):void
		{
			var shareParams:Object = new Object();
			shareParams.type = ShareType.SHARE_APPS;
			shareParams.title = title;
			if(isIOS)
			{
				shareParams.titleUrl = titleUrl;
				shareParams.imageUrl = imageUrl;				
			}else{
				shareParams.url = titleUrl;
				shareParams.imagePath = imageUrl;			
			}
			shareParams.text = text;
			shareSDK.showShareView(PlatformID.WeChatSession, shareParams);
		}

		public function get completeFunc():Function
		{
			return _completeFunc;
		}

		public function set completeFunc(value:Function):void
		{
			_completeFunc = value;
		}

	}
}