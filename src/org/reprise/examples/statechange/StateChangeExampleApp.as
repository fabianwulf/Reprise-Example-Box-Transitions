package org.reprise.examples.statechange
{
	import reprise.ui.DocumentView;

	import assets.Fonts;

	import reprise.controls.Label;
	import reprise.controls.RadioButton;
	import reprise.controls.RadioButtonGroup;
	import reprise.core.Application;
	import reprise.core.UIRendererFactory;
	import reprise.external.XMLResource;
	import reprise.ui.UIComponent;

	import org.reprise.examples.statechange.view.ContentBox;

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
		private var m_buttonGroup : RadioButtonGroup;
		private var m_buttonsContainer : UIComponent;
		private var m_buttonLeft : RadioButton;
		private var m_buttonMiddle : RadioButton;
		private var m_buttonRight : RadioButton;
		private var m_content : ContentBox;
		private var m_claim : Label;
		
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
		override protected function initialize() : void
		{
			super.initialize();
		}

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
			
			log(XML(m_xhtmlData.content()).children()[0]);
			
			m_rootElement.initFromXML(XML(m_xhtmlData.content()).children()[0]);
			addListeners();
		}
		
//		override protected function startApplication() : void
//		{
//			super.startApplication();
//			createComponents();
//		}
		
//		protected function createComponents() : void
//		{
//			createButtonGroup();
//			createContents();
//			createClaim();
//			addListeners();
//		}
		
		private function createClaim() : void
		{
			m_claim = Label(m_rootElement.addComponent(null, 'claim', Label));
			m_claim.label = 'Reprise-Framework.org';
		}

		private function addListeners() : void
		{
			m_rootElement.getElementById('leftButton').addEventListener(MouseEvent.CLICK, leftButton_onClick);
			m_rootElement.getElementById('middleButton').addEventListener(MouseEvent.CLICK, middleButton_onClick);
			m_rootElement.getElementById('rightButton').addEventListener(MouseEvent.CLICK, rightButton_onClick);
			m_rootElement.addEventListener(MouseEvent.ROLL_OVER, self_onMouseOver);
			m_rootElement.addEventListener(MouseEvent.ROLL_OUT, self_onMouseOut);
		}		

		protected function createContents() : void
		{
			m_content = ContentBox(m_rootElement.addComponent(null, 'content', ContentBox));
		}

		protected function createButtonGroup() : void
		{
			m_buttonsContainer = m_rootElement.addComponent(null, 'buttonsContainer');
			
			m_buttonLeft = RadioButton(
				m_buttonsContainer.addComponent('radiobutton leftButton radioFontStyle', null, RadioButton));
			m_buttonMiddle = RadioButton(
				m_buttonsContainer.addComponent('radiobutton middleButton radioFontStyle', null, RadioButton));
			m_buttonRight =	RadioButton(
				m_buttonsContainer.addComponent('radiobutton rightButton radioFontStyle', null, RadioButton));
			
			m_buttonLeft.setLabel('Lefty');
			m_buttonMiddle.setLabel('Middleton');
			m_buttonRight.setLabel('Righto');
			
			m_buttonGroup = new RadioButtonGroup('buttonGroup');
			m_buttonGroup.addRadioButton(m_buttonLeft);
			m_buttonGroup.addRadioButton(m_buttonMiddle);
			m_buttonGroup.addRadioButton(m_buttonRight);
			m_buttonGroup.setRadioButtonSelected(m_buttonLeft, true);
			
		}
		
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
			m_rootElement.removeCSSClass('show');
			m_rootElement.cssID = 'noneActive';
		}

		private function self_onMouseOver(event : MouseEvent) : void
		{
			m_rootElement.addCSSClass('show');
		}
	}
}
