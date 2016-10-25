//#GOGP_IGNORE_BEGIN
///////////////////////////////////////////////////////////////////
//
// !!!!!!!!!!!! NEVER MODIFY THIS FILE MANUALLY !!!!!!!!!!!!
//
// This file was auto-generated by tool [github.com/vipally/gogp]
// Last update at: [Tue Oct 25 2016 22:46:23]
// Generate from:
//   [github.com/vipally/gx/stl/gp/comparer.go]
//   [github.com/vipally/gx/stl/gp/gp.gpg] [GOGP_REVERSE_comparer]
//
// Tool [github.com/vipally/gogp] info:
// CopyRight 2016 @Ally Dale. All rights reserved.
// Author  : Ally Dale(vipally@gmail.com)
// Blog    : http://blog.csdn.net/vipally
// Site    : https://github.com/vipally
// BuildAt : [Oct 24 2016 20:25:45]
// Version : 3.0.0.final
// 
///////////////////////////////////////////////////////////////////
//#GOGP_IGNORE_END

//this file is used to import by other gp files
//it cannot use independently
//simulation C++ stl functors
<PACKAGE>



type Comparer<GLOBAL_NAME_PART>Part interface {
	F(left, right <VALUE_TYPE>) bool
}

type Comparer<GLOBAL_NAME_PART>Creator int

const (
	LESSER_<GLOBAL_NAME_PART> Comparer<GLOBAL_NAME_PART>Creator = iota
	GREATER_<GLOBAL_NAME_PART>
)

func (me Comparer<GLOBAL_NAME_PART>Creator) Create() (cmp Comparer<GLOBAL_NAME_PART>) {
	switch me {
	case LESSER_<GLOBAL_NAME_PART>:
		cmp = Lesser<GLOBAL_NAME_PART>(0)
	case GREATER_<GLOBAL_NAME_PART>:
		cmp = Greater<GLOBAL_NAME_PART>(0)
	}
	return
}

type Lesser<GLOBAL_NAME_PART> byte

func (this Lesser<GLOBAL_NAME_PART>) F(left, right <VALUE_TYPE>) (ok bool) {
	//#GOGP_IFDEF GOGP_HasLess
	ok = left.Less(right)
	//#GOGP_ELSE
	ok = left < right
	//#GOGP_ENDIF
	return
}

type Greater<GLOBAL_NAME_PART> byte

func (this Greater<GLOBAL_NAME_PART>) F(left, right <VALUE_TYPE>) (ok bool) {
	//#GOGP_IFDEF GOGP_HasGreat
	ok = left.Great(right)
	//#GOGP_ELSE
	ok = left > right
	//#GOGP_ENDIF
	return
}
