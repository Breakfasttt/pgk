package test;
import assets.model.library.ModelData;
import assets.model.library.ModelDataLoader;
import assets.model.library.ModelFactory;
import assets.model.library.ModelLibrary;
import core.Application;
import core.entity.Entity;
import input.WorldSignal;
import input.data.PointerData;
import openfl.Lib;
import openfl.display.Sprite;
import standard.components.graphic.animation.Animation;
import standard.components.graphic.display.impl.Layer;
import standard.components.input.PointerBehavioursComponent;
import standard.components.input.utils.DragEntity;
import standard.components.input.utils.EntityAsSimpleButton;
import standard.components.space2d.Rotation2D;
import standard.components.space2d.UtilitySize2D;
import standard.components.space2d.resizer.impl.RatioResizer;
import standard.factory.EntityFactory;
import standard.module.debug.DebugModule;
import standard.module.graphic.GameElementModule;
import standard.module.graphic.LayerModule;
import standard.module.graphic.LocationModule;
import standard.module.graphic.AnimRenderModule;
import standard.module.graphic.PopUpModule;
import standard.module.graphic.ScreenModule;
import standard.module.input.PointerBehavioursModule;
import standard.utils.uicontainer.impl.PopupContainer;
import test.component.CompTest;
import test.component.CompTest2;
import test.misc.popup.TestPopup;
import test.misc.screen.TestScreen;
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
		
		var modelLibrary : ModelLibrary = new ModelLibrary(new ModelFactory());
		modelLibrary.loadModels("model/modelDescriptor.json");
		var entityFactory : EntityFactory = new EntityFactory(modelLibrary);
		
		
		var layModule : LayerModule = new LayerModule(Lib.current.stage);
		var gameElementModule : GameElementModule = new GameElementModule();
		var locModule : LocationModule = new LocationModule(Lib.current.stage);
		
		app.addModule(layModule, 0);
		app.addModule(gameElementModule, 1);
		app.addModule(locModule, 2);
		
		var backLayer : Entity = entityFactory.createLayer("backLayer", -1, app.width, app.height);
		var mainLayer : Entity = entityFactory.createLayer("mainLayer", 0, app.width, app.height, Anchor.center, Anchor.center);
		mainLayer.add(new RatioResizer());
		
		var firstElement : Entity = entityFactory.createGameElement("square1", backLayer,"test.png", 1, Anchor.center, Anchor.center, 1.0, 1.0);
		var secondElement : Entity = entityFactory.createGameElement("square1", mainLayer, "test.png", 1, Anchor.topLeft, Anchor.topLeft, 1.0, 1.0);
		
		var thirdElement : Entity = entityFactory.createGameElement("square3", mainLayer, "test.png", 2, new Anchor(50,50,false), Anchor.center, 0.5, 0.5);
		var fourthElement : Entity = entityFactory.createGameElement("square4", mainLayer, "test.png", 3, Anchor.center, Anchor.center, 0.2, 0.2);
		
		var miniLayer : Entity = entityFactory.createLayer("miniLayer", 1, 50, 50, Anchor.center, Anchor.center);
		var fifthElement : Entity = entityFactory.createGameElement("square5", miniLayer, "img/placeholder.png", 4, Anchor.topLeft, Anchor.topLeft, 0.3, 0.3);
		
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
	 * Custom test
	 */
	public static function customTest() : Void
	{
		var app : Application;
		app = new Application();
		app.init("Application test", 1280, 720);
		
		var modelLibrary : ModelLibrary = new ModelLibrary(new ModelFactory());
		modelLibrary.loadModels("model/modelDescriptor.json");
		var entityFactory : EntityFactory = new EntityFactory(modelLibrary);
		
		var layModule : LayerModule = new LayerModule(Lib.current.stage);
		var gameElementModule : GameElementModule = new GameElementModule();
		var locModule : LocationModule = new LocationModule(Lib.current.stage);
		var pointerModule : PointerBehavioursModule = new PointerBehavioursModule();
		var renderModule : AnimRenderModule = new AnimRenderModule();
		
		var mainLayer : Entity = entityFactory.createLayer("mainLayer", 0, app.width, app.height, Anchor.center, Anchor.center);
		mainLayer.add(new RatioResizer());	
		
		var screenLayer : Entity = entityFactory.createLayer("screenLayer", 1, app.width, app.height, Anchor.center, Anchor.center);
		screenLayer.add(new RatioResizer());	
		
		var popupLayer : Entity = entityFactory.createLayer("popupLayer", 2, app.width, app.height, Anchor.center, Anchor.center);
		popupLayer.add(new RatioResizer());
		
		var debugLayer : Entity = entityFactory.createLayer("debugLayer", 2, app.width, app.height, Anchor.center, Anchor.center);
		debugLayer.add(new RatioResizer());	
		
		var screenModule : ScreenModule = new ScreenModule(screenLayer.getComponent(Layer));
		var popupModule : PopUpModule = new PopUpModule(popupLayer.getComponent(Layer), popupLayer.getComponent(UtilitySize2D));
		
		app.addModule(layModule, 0);
		app.addModule(screenModule, 1);
		app.addModule(popupModule, 2);
		app.addModule(gameElementModule, 3);
		app.addModule(renderModule, 4);
		app.addModule(locModule, 5);
		app.addModule(pointerModule, 6);
		app.addModule(new DebugModule(debugLayer, entityFactory), 7);
		
		
		/*var firstElement : Entity = entityFactory.createGameElement("square1", mainLayer, "spritesheet1", 1, Anchor.center, Anchor.topLeft, "walk-front");
		var secondElement : Entity = entityFactory.createGameElement("square2", firstElement, "test2", 1, Anchor.center, Anchor.center, "twice", 1.0, 1.0);
		rot = new Rotation2D(0);
		secondElement.add(rot);*/
		//secondElement.getComponent(UtilitySize2D).autoUtilitySize = true;
		//secondElement.add(new UtilitySize2D(50, 50));
		
		//var popupTest : TestPopup = new TestPopup(app, entityFactory); 
		//var popupTest2 : TestPopup = new TestPopup(app, entityFactory); 
		
		var screenTest : TestScreen = new TestScreen("screen1", app, entityFactory);
		var screenTest2 : TestScreen = new TestScreen("screen2", app, entityFactory);
		
		//var entPointerBehaviour : PointerBehavioursComponent = new PointerBehavioursComponent();
		//entPointerBehaviour.addBehaviour(new DragEntity(locModule), 0);
		//var button : EntityAsSimpleButton = new EntityAsSimpleButton(false);
		//entPointerBehaviour.addBehaviour(button,0);
		//secondElement.add(entPointerBehaviour);
		//secondElement.getComponent(Animation).speedRatio = 3.0;
		
		app.addEntity(mainLayer);
		app.addEntity(screenLayer);
		app.addEntity(popupLayer);
		app.addEntity(screenTest.entity);
		app.addEntity(screenTest2.entity);
		//app.addEntity(popupTest.entity);
		//app.addEntity(popupTest2.entity);
		//app.addEntity(secondElement);
		//app.addEntity(firstElement);
		
		screenModule.goToScreen("screen1");
		WorldSignal.self.worldPointerPress.add(function(data : PointerData) { var rand = Std.random(2) + 1; screenModule.goToScreen("screen" + rand); });
		
		//locModule.debugShowLocGroupRect();
		//app.tick.tick.add(testTotation);
	}	
	
	private static var rot : Rotation2D;
	
	private static function testTotation(d : Float)
	{
		rot.angle += d /1000 * 45.0;
	}
	
	private static function test(text : String) : Void
	{
		trace(text);
	}
	
}