package com.sparkTree
{
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;

import mx.styles.IStyleClient;

import spark.components.supportClasses.ItemRenderer;

public class TreeItemRenderer extends ItemRenderer implements ITreeItemRenderer
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	public function TreeItemRenderer()
	{
		super();
		
		addEventListener(Event.ADDED_TO_STAGE, addedToStage);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------
	
	private var tree:Tree;
	
	//--------------------------------------------------------------------------
	//
	//  Implementation of ITreeItemRenderer: properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  level
	//----------------------------------

	protected var _level:int = 0;
	
	[Bindable("levelChange")]
	public function get level():int
	{
		return _level;
	}
	
	public function set level(value:int):void
	{
		if (_level == value)
			return;
		
		_level = value;
		dispatchEvent(new Event("levelChange"));
	}
	
	//----------------------------------
	//  parents
	//----------------------------------

	protected var _parents:Vector.<Object>;
	
	[Bindable("parentsChange")]
	public function get parents():Vector.<Object>
	{
		return _parents;
	}
	
	public function set parents(value:Vector.<Object>):void
	{
		// do not check on equality
		
		_parents = value;
		dispatchEvent(new Event("parentsChange"));
	}
	
	//----------------------------------
	//  isBranch
	//----------------------------------

	protected var _isBranch:Boolean = false;
	
	[Bindable("isBranchChange")]
	public function get isBranch():Boolean
	{
		return _isBranch;
	}
	
	public function set isBranch(value:Boolean):void
	{
		if (_isBranch == value)
			return;
		
		_isBranch = value;
		dispatchEvent(new Event("isBranchChange"));
	}
	
	//----------------------------------
	//  isLeaf
	//----------------------------------

	protected var _isLeaf:Boolean = true;
	
	[Bindable("isLeafChange")]
	public function get isLeaf():Boolean
	{
		return _isLeaf;
	}
	
	public function set isLeaf(value:Boolean):void
	{
		if (_isLeaf == value)
			return;
		
		_isLeaf = value;
		dispatchEvent(new Event("isLeafChange"));
	}
	
	//----------------------------------
	//  hasChildren
	//----------------------------------

	protected var _hasChildren:Boolean = false;
	
	[Bindable("hasChildrenChange")]
	public function get hasChildren():Boolean
	{
		return _hasChildren;
	}
	
	public function set hasChildren(value:Boolean):void
	{
		if (_hasChildren == value)
			return;
		
		_hasChildren = value;
		dispatchEvent(new Event("hasChildrenChange"));
	}
	
	//----------------------------------
	//  isOpen
	//----------------------------------
	
	protected var _isOpen:Boolean = false;
	
	[Bindable("isOpenChange")]
	public function get isOpen():Boolean
	{
		return _isOpen;
	}
	
	public function set isOpen(value:Boolean):void
	{
		if (_isOpen == value)
			return;
		
		_isOpen = value;
		dispatchEvent(new Event("isOpenChange"));
	}
	
	//----------------------------------
	//  icon
	//----------------------------------
	
	protected var _icon:Class;
	
	[Bindable("iconChange")]
	public function get icon():Class
	{
		return _icon;
	}
	
	public function set icon(value:Class):void
	{
		if (_icon == value)
			return;
		
		_icon = value;
		dispatchEvent(new Event("iconChange"));
	}
	
	//----------------------------------
	//  indentation
	//----------------------------------
	
	private var _treeIndentation:Number = 17; // default MX Tree indentation
	
	[Bindable("levelChange")]
	public function get indentation():Number
	{
		if (!owner)
			return 0;
		
		var value:Number = owner ? IStyleClient(owner).getStyle("indentation") : NaN;
		if (!isNaN(value))
			_treeIndentation = value;
		
		return _level * _treeIndentation;
	}
	
	//----------------------------------
	//  disclosureIconVisible
	//----------------------------------
	
	[Bindable("hasBranchChange")]
	[Bindable("hasChildrenChange")]
	public function get disclosureIconVisible():Boolean
	{
		return isBranch && hasChildren;
	}
	
	//----------------------------------
	//  textColor
	//----------------------------------
	
	private var _textColor:uint = 0;
	
	[Bindable("textColorChange")]
	public function get textColor():uint
	{
		return _textColor;
	}
	
	public function set textColor(value:uint):void
	{
		if (_textColor == value)
			return;
		
		_textColor = value;
		dispatchEvent(new Event("textColorChange"));
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overriden methods
	//
	//--------------------------------------------------------------------------
	
	override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
	{
		super.updateDisplayList(unscaledWidth, unscaledHeight);
		
		textColor = getTextColor();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
	public function toggle():void
	{
		tree.expandItem(data, !_isOpen);
	}
	
	public function getTextColor():uint
	{
		if (!tree)
			return 0;
		if (!tree.useTextColors)
			return getStyle("color");
		
		if (!enabled)
			return getStyle("disabledColor");
		else if (selected)
			return getStyle("textSelectedColor");
		else if (hovered)
			return getStyle("textRollOverColor");
		else
			return getStyle("color");
	}
	
	private function addedToStage(event:Event):void
	{
		var container:DisplayObjectContainer = owner;
		while (!(container is Tree) && container)
		{
			container = container.parent;
		}
		tree = Tree(container);
	}
	
}
}