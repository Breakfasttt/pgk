package test;
import core.Application;
import core.entity.Entity;
import input.mouseBehaviour.DragBehaviour;
import openfl.Lib;
import openfl.display.Sprite;
import standard.factory.EntityFactory;
import standard.module.graphic.DisplayModule;
import standard.module.graphic.RepresentationModule;
import test.component.CompTest;
import test.component.CompTest2;
import test.module.ModuleTest;
import test.module.ModuleTest2;
import tools.math.Anchor;

/**
 * A Class who contains some static function to test functionnality
 * @author Breakyt
 */
class TestMe 
{

	/**
	 * Test :
	 * - Application creation
	 * - Entity creation
	 * - Module creation
	 * - Add/remove Module from Application
	 * - Add/remove Entity from Application
	 * - Add/Remove  Component from Entity
	 * - ComponentGroup creation/destruction logique is tested with Add/remove action
	 * - Module update and ComponentGroup signal function
	 */
	public static function testApplicationModuleEntityAndComposant() 
	{
		var app : Application;
		app = new Application();
		app.init("Application test", 800, 600);
		
		var mod1 : ModuleTest = new ModuleTest();
		var mod2 : ModuleTest2 = new ModuleTest2();
		
		var e : Entity = new Entity("TestEntity");
		
		var comp1 : CompTest = new CompTest();
		var comp2 : CompTest2 = new CompTest2();
		
		app.addModule(mod1);
		app.addModule(mod2);
		
		e.add(comp1);
		e.add(comp2);
		
		app.addEntity(e);
		
		e.remove(comp2);
		
		app.removeModule(mod1);
		
		app.removeEntity(e);
		
		e.remove(comp1);
		e.add(comp2);
		
		app.addEntity(e);
		
		e.add(comp1);
		
		app.addModule(mod1);		
	}
	
	public static function testDisplayAndRepresentation() : Void
	{
		var app : Application;
		app = new Application();
		app.init("Application test", 800, 600);
		
		var displayModule : DisplayModule = new DisplayModule(Lib.current.stage);
		var representationModule : RepresentationModule = new RepresentationModule();
		
		app.addModule(displayModule);
		app.addModule(representationModule);
		
		var backLayer : Entity = EntityFactory.createLayer("backLayer", -1, app.width, app.height);
		var mainLayer : Entity = EntityFactory.createLayer("mainLayer", 0, app.width, app.height);
		
		var firstElement : Entity = EntityFactory.createGraphicElement("square4", "backLayer","test.png", app.width/2.0, app.height/2.0, 1, Anchor.center.clone(), 1.0, 1.0);
		
		var secondElement : Entity = EntityFactory.createGraphicElement("square1", "mainLayer", "test.png", 0.0, 0.0, 0, Anchor.topLeft.clone(), 1.0, 1.0);
		var thirdElement : Entity = EntityFactory.createGraphicElement("square2", "mainLayer", "test.png", 50.0, 50.0, 1, Anchor.center.clone(), 0.5, 0.5);
		var fourthElement : Entity = EntityFactory.createGraphicElement("square3", "mainLayer", "test.png", app.width / 2.0, app.height / 2.0, 1, Anchor.center.clone(), 0.5, 0.5);
		
		
		app.addEntity(mainLayer);
		app.addEntity(backLayer);
		
		app.addEntity(firstElement);
		app.addEntity(secondElement);
		app.addEntity(thirdElement);
		app.addEntity(fourthElement);
		
	}
	
	
	/**
	 * Test Drag mouse behaviour (therefore Test MouseSignal)
	 */
	public static function testDragMouseBehaviour() : Void
	{
		var redSquare : Sprite;
		var mouseBehaviour : DragBehaviour;		
		
		redSquare = new Sprite();
		redSquare.graphics.beginFill(0xff00000);
		redSquare.graphics.drawRect(0, 0, 50, 50);
		redSquare.graphics.endFill();
		
		redSquare.x = 50;
		redSquare.y = 50;
		
		Lib.current.stage.addChild(redSquare);
		
		mouseBehaviour = new DragBehaviour(redSquare);
		mouseBehaviour.stageAsBoundary = true;
		//m_mouseBehaviour.setBoundary(0, Lib.current.stage.stageWidth, 0, Lib.current.stage.stageHeight);
	}
	
}