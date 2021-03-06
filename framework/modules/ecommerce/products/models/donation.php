<?php

##################################################
#
# Copyright (c) 2004-2013 OIC Group, Inc.
#
# This file is part of Exponent
#
# Exponent is free software; you can redistribute
# it and/or modify it under the terms of the GNU
# General Public License as published by the Free
# Software Foundation; either version 2 of the
# License, or (at your option) any later version.
#
# GPL: http://www.gnu.org/licenses/gpl.txt
#
##################################################

/**
 * @subpackage Models
 * @package Modules
 */

class donation extends product {
	public $table = 'product';
	//public $has_and_belongs_to_many = array('storeCategory');

    public $product_name = 'Online Donation';
    public $product_type = 'donation';
    public $requiresShipping = false; 
	public $requiresBilling  = true; 
    public $isQuantityAdjustable = false;
    
    protected $attachable_item_types = array(
//        'content_expCats'=>'expCat',
//        'content_expComments'=>'expComment',
//        'content_expDefinableFields'=> 'expDefinableField',
        'content_expFiles'=>'expFile',
//        'content_expRatings'=>'expRating',
//        'content_expSimpleNote'=>'expSimpleNote',
//        'content_expTags'=>'expTag',
    );

	public function __construct($params=array(), $get_assoc=true, $get_attached=true) {
		parent::__construct($params, $get_assoc, $get_attached);
//		$this->price = '';
        $this->price = $this->base_price;
	}

    public function find($range='all', $where=null, $order=null, $limit=null, $limitstart=0, $get_assoc=true, $get_attached=true, $except=array(), $cascade_except = false) {
        global $db;

        if (is_numeric($range)) {
            $where = 'id='.intval($range); // If we hit this then we are expecting just a simple id 
            $range = 'first';
        } 

        $sql  = "product_type='donation'";
        if (!empty($where)) $sql  .= $where;
        $sql .= empty($order) ? '' : ' ORDER BY '.$order;

        if (strcasecmp($range, 'all') == 0) {
            $sql .= empty($limit) ? '' : ' LIMIT '.$limitstart.','.$limit;
            return $db->selectExpObjects($this->tablename, $sql, $this->classname);
        } elseif (strcasecmp($range, 'first') == 0) {   
            $sql .= ' LIMIT 0,1';
            $records = $db->selectExpObjects($this->tablename, $sql, $this->classname);
            return empty($records) ? null : $records[0];  
        } elseif (strcasecmp($range, 'bytitle') == 0) {
            $records = $db->selectExpObjects($this->tablename, "title='".$where."' OR sef_url='".$where."'", $this->classname);
            return empty($records) ? null : $records[0];
        } elseif (strcasecmp($range, 'count') == 0) {
            return $db->countObjects($this->tablename, $sql);
        } elseif (strcasecmp($range, 'in') == 0) {
            if (!is_array($where)) return array();
            foreach ($where as $id) $records[] = new $this->classname($id);
            return $records;
        } elseif (strcasecmp($range, 'bytag') == 0) {
            $sql  = 'SELECT DISTINCT m.id FROM '.DB_TABLE_PREFIX.'_'.$this->table.' m ';
            $sql .= 'JOIN '.DB_TABLE_PREFIX.'_content_expTags ct '; 
            $sql .= 'ON m.id = ct.content_id WHERE ct.exptags_id='.$where." AND ct.content_type='".$this->classname."'";
            $tag_assocs = $db->selectObjectsBySql($sql);
            $records = array();
            foreach ($tag_assocs as $assoc) {
                $records[] = new $this->classname($assoc->id);
            }
            return $records;
        }
    }
    
    public function cartSummary($item) {
        $view = new controllertemplate($this, $this->getForm('cartSummary'));
	    $view->assign('product', $this);
	    $view->assign('item', $item);
	    
	    // grab all the registrants
	    $message = expUnserialize($item->extra_data);
	    $view->assign('message', $message);
	    
        return $view->render('cartSummary');
    }
    
	function getPrice($orderitem=null) {
		return 1;
	}
	
	function addToCart($params, $orderid = null) {
//	    if (empty($params['dollar_amount'])) {  //FIXME we don't ever pass this param
//	        return false;
//	    } else {
	        $item = new orderitem($params);
            if (empty($params['dollar_amount'])) $params['dollar_amount'] = $this->price;
	        $item->products_price = preg_replace("/[^0-9.]/","",$params['dollar_amount']);
	        
	        $product = new product($params['product_id']);
	        $item->products_name = $params['dollar_amount'].' '.$this->product_name.' to '.$product->title;

	        // we need to unset the orderitem's ID to force a new entry..other wise we will overwrite any
	        // other giftcards in the cart already
	        $item->id = null;
	        $item->quantity = $this->getDefaultQuantity();
		    $item->save();
		    return true;
//	    }
	}

    public function hasUserInputFields() {
        return true;
    }

}

?>