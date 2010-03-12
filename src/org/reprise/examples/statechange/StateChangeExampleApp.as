package org.reprise.examples.statechange
{
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import reprise.ui.DocumentView;

	import assets.Fonts;

	import reprise.controls.Label;
	import reprise.controls.LabelButton;
	import reprise.controls.RadioButton;
	import reprise.controls.RadioButtonGroup;
	import reprise.core.Application;
	import reprise.core.UIRendererFactory;
	import reprise.external.XMLResource;
	import reprise.ui.UIComponent;

	import flash.events.MouseEvent;

	/**
	 * @author fabian wulf
	 */
	public class StateChangeExampleApp extends Application
	{
		/*******************************************************************************************
		*								public properties										   *
		*******************************************************************************************/
		public static const CSS_URL : String = 'style/main.css';
		
		/*******************************************************************************************
		*								protected/ private properties							   *
		*******************************************************************************************/		
		private var m_xhtmlData : XMLResource;
		
		protected static var g_fonts : Fonts;
		
		
		/*******************************************************************************************
		*								public methods											   *
		*******************************************************************************************/
		public function StateChangeExampleApp()
		{
		}
		
		
		/*******************************************************************************************
		*								protected/ private methods								   *
		*******************************************************************************************/
		override protected function loadResources() : void
		{
			m_xhtmlData = new XMLResource('../components.xml');
			addResource(m_xhtmlData);
		}
		
		override protected function startApplication() : void
		{
			var uiRendererFactory : UIRendererFactory = m_rootElement.uiRendererFactory();
			uiRendererFactory.registerTagRenderer('div', UIComponent);
			uiRendererFactory.registerTagRenderer('group', RadioButtonGroup);
			uiRendererFactory.registerTagRenderer('button', RadioButton);
			uiRendererFactory.registerTagRenderer('label', Label);
			uiRendererFactory.registerTagRenderer('labelButton', LabelButton);
			
			m_rootElement.initFromXML(XML(m_xhtmlData.content()).children()[0]);
			addListeners();
		}

		private function addListeners() : void
		{
			m_rootElement.getElementById('leftButton').addEventListener(MouseEvent.CLICK, leftButton_onClick);
			m_rootElement.getElementById('middleButton').addEventListener(MouseEvent.CLICK, middleButton_onClick);
			m_rootElement.getElementById('rightButton').addEventListener(MouseEvent.CLICK, rightButton_onClick);
//			m_rootElement.getElementById('claim').addEventListener(MouseEvent.CLICK, claim_onClick);
			m_rootElement.addEventListener(MouseEvent.ROLL_OVER, self_onMouseOver);
			m_rootElement.addEventListener(MouseEvent.ROLL_OUT, self_onMouseOut);
		}
		
		private function resetRadioButtons() : void
		{
			var items : Array = m_rootElement.getElementsByClassName('navigationItem');
			for each (var button : RadioButton in items)
			{
				button.removeCSSPseudoClass('checked');
			}
		}
		
//		private function claim_onClick(event : MouseEvent) : void
//		{
//			var request : URLRequest = new URLRequest('http://github.com/tschneidereit/Reprise');
//			navigateToURL(request, '_blank');
//		}

		private function rightButton_onClick(event : MouseEvent) : void
		{
			m_rootElement.cssID = 'rightActive';
		}

		private function middleButton_onClick(event : MouseEvent) : void
		{
			m_rootElement.cssID = 'middleActive';
		}

		private function leftButton_onClick(event : MouseEvent) : void
		{
			m_rootElement.cssID = 'leftActive';
		}
		
		private function self_onMouseOut(event : MouseEvent) : void
		{
			m_rootElement.cssID = 'noneActive';
			m_rootElement.removeCSSClass('show');
			resetRadioButtons();
		}

		private function self_onMouseOver(event : MouseEvent) : void
		{
			m_rootElement.addCSSClass('show');
		}
	}
}
