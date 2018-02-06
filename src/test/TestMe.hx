package test;
import core.Application;
import core.entity.Entity;
import openfl.Lib;
import openfl.display.Sprite;
import standard.components.input.PointerBehavioursComponent;
import standard.components.input.utils.DragEntity;
import standard.components.space2d.resizer.impl.RatioResizer;
import standard.factory.EntityFactory;
import standard.module.debug.DebugModule;
import standard.module.graphic.GameElementModule;
import standard.module.graphic.LayerModule;
import standard.module.graphic.LocationModule;
import standard.module.input.PointerBehavioursModule;
import test.component.CompTest;
import test.component.CompTest2;
import test.module.ModuleTest;
import test.module.ModuleTest2;
import tools.math.Anchor;
import assets.model.Model;

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
		
		var line : Sprite  = new Sprite();
		line.graphics.beginFill(0xff0000);
		line.graphics.lineStyle(2.0,0xff0000);
		line.graphics.lineTo(0, app.height);
		line.graphics.endFill();
		line.x = app.width / 2.0;
		line.y = 0;
		
		var line2 : Sprite  = new Sprite();
		line2.graphics.beginFill(0xff0000);
		line2.graphics.lineStyle(2.0,0xff0000);
		line2.graphics.lineTo(app.width, 0);
		line2.graphics.endFill();
		line2.x = 0.0;
		line2.y = app.height / 2.0;
		
		Lib.current.stage.addChild(line);
		Lib.current.stage.addChild(line2);
		
		
		var layModule : LayerModule = new LayerModule(Lib.current.stage);
		var gameElementModule : GameElementModule = new GameElementModule(layModule);
		var locModule : LocationModule = new LocationModule(Lib.current.stage);
		
		app.addModule(layModule, 0);
		app.addModule(gameElementModule, 1);
		app.addModule(locModule, 2);
		
		var backLayer : Entity = EntityFactory.createLayer("backLayer", -1, app.width, app.height);
		var mainLayer : Entity = EntityFactory.createLayer("mainLayer", 0, app.width, app.height, Anchor.center, Anchor.center);
		mainLayer.add(new RatioResizer());
		
		var firstElement : Entity = EntityFactory.createGameElement("square1", "backLayer","test.png", 1, Anchor.center, Anchor.center, 1.0, 1.0);
		var secondElement : Entity = EntityFactory.createGameElement("square1", "mainLayer", "test.png", 1, Anchor.topLeft, Anchor.topLeft, 1.0, 1.0);
		
		var thirdElement : Entity = EntityFactory.createGameElement("square3", "mainLayer", "test.png", 2, new Anchor(50,50,false), Anchor.center, 0.5, 0.5);
		var fourthElement : Entity = EntityFactory.createGameElement("square4", "mainLayer", "test.png", 3, Anchor.center, Anchor.center, 0.2, 0.2);
		
		var miniLayer : Entity = EntityFactory.createLayer("miniLayer", 1, 50, 50, Anchor.center, Anchor.center);
		var fifthElement : Entity = EntityFactory.createGameElement("square5", "miniLayer", "img/placeholder.png", 4, Anchor.topLeft, Anchor.topLeft, 0.3, 0.3);
		
		app.addEntity(mainLayer);
		//app.addEntity(backLayer);
		//app.addEntity(miniLayer);
		
		//app.addEntity(firstElement);
		app.addEntity(secondElement);
		//app.addEntity(thirdElement);
		//app.addEntity(fourthElement);
		//app.addEntity(fifthElement);
		
		//locModule.debugDrawAllDisplayRect();
	}
	
	
	/**
	 * Test Drag mouse behaviour (therefore Test MouseSignal)
	 */
	public static function testDragMouseBehaviour() : Void
	{
		var app : Application;
		app = new Application();
		app.init("Application test", 1280, 720);
		
		
		var layModule : LayerModule = new LayerModule(Lib.current.stage);
		var gameElementModule : GameElementModule = new GameElementModule(layModule);
		var locModule : LocationModule = new LocationModule(Lib.current.stage);
		var pointerModule : PointerBehavioursModule = new PointerBehavioursModule();
		
		app.addModule(layModule, 0);
		app.addModule(gameElementModule, 1);
		app.addModule(locModule, 2);
		app.addModule(pointerModule, 3);
		app.addModule(new DebugModule(), 4);
		
		
		var mainLayer : Entity = EntityFactory.createLayer("mainLayer", 0, app.width, app.height, Anchor.center, Anchor.center);
		mainLayer.add(new RatioResizer());
		
		var firstElement : Entity = EntityFactory.createGameElement("square1", "mainLayer", "test.png", 1, Anchor.topLeft, Anchor.topLeft, 1.0, 1.0);
		
		var entPointerBehaviour : PointerBehavioursComponent = new PointerBehavioursComponent();
		entPointerBehaviour.addBehaviour(new DragEntity(locModule), 0);
		firstElement.add(entPointerBehaviour);			
		
		app.addEntity(mainLayer);
		app.addEntity(firstElement);
		
		//locModule.debugShowLocGroupRect();
		//locModule.forceResize();
	}
	
	
}