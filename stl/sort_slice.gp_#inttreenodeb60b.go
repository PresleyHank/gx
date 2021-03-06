///////////////////////////////////////////////////////////////////
//
// !!!!!!!!!!!! NEVER MODIFY THIS FILE MANUALLY !!!!!!!!!!!!
//
// This file was auto-generated by tool [github.com/vipally/gogp]
// Last update at: [Sat Apr 01 2017 22:48:09]
// Generate from:
//   [github.com/vipally/gx/stl/gp/sort_slice.gp]
//   [github.com/vipally/gx/stl/stl.gpg] [_tree_sort_slice_int]
//
// Tool [github.com/vipally/gogp] info:
// CopyRight 2016 @Ally Dale. All rights reserved.
// Author  : Ally Dale(vipally@gmail.com)
// Blog    : http://blog.csdn.net/vipally
// Site    : https://github.com/vipally
// BuildAt :
// Version : 3.0.0.final
//
///////////////////////////////////////////////////////////////////

//this file define a template type for sort

package stl

import "sort"

////////////////////////////////////////////////////////////////////////////////

var gIntTreeNodeSortSliceGbl struct {
	cmp CmpIntTreeNode
}

func init() {
	gIntTreeNodeSortSliceGbl.cmp = gIntTreeNodeSortSliceGbl.cmp.CreateByName("")
}

//new sort object
func NewIntTreeNodeSortSlice(capacity int) *IntTreeNodeSortSlice {
	p := &IntTreeNodeSortSlice{}
	p.Init(capacity)
	return p
}

//sort slice
type IntTreeNodeSortSlice struct {
	d []*IntTreeNode
}

//init
func (this *IntTreeNodeSortSlice) Init(capacity int) {
	this.d = make([]*IntTreeNode, 0, capacity)
}

//sort
func (this *IntTreeNodeSortSlice) Sort() {
	sort.Sort(this)
}

//data buffer
func (this *IntTreeNodeSortSlice) Buffer() []*IntTreeNode {
	return this.d
}

//push
func (this *IntTreeNodeSortSlice) Push(v *IntTreeNode) int {
	this.d = append(this.d, v)
	return this.Len()
}

//insert
func (this *IntTreeNodeSortSlice) Insert(v *IntTreeNode, idx int) int {
	if idx >= 0 && idx < this.Len() {
		right := this.d[idx+1:]
		this.d = append(this.d[:idx], v)
		this.d = append(this.d, right...)
	} else {
		this.d = append(this.d, v)
	}
	return this.Len()
}

//remove
func (this *IntTreeNodeSortSlice) Remove(idx int) (r *IntTreeNode, ok bool) {
	if r, ok = this.Get(idx); ok {
		right := this.d[idx+1:]
		this.d = append(this.d[:idx], right...)
	}
	return
}

//pop
func (this *IntTreeNodeSortSlice) Pop() (r *IntTreeNode, ok bool) {
	if ok = len(this.d) > 0; ok {
		r = (this.d)[len(this.d)-1]
	}
	this.d = (this.d)[:len(this.d)-1]
	return
}

//get
func (this *IntTreeNodeSortSlice) Get(idx int) (r *IntTreeNode, ok bool) {
	if ok = idx >= 0 && idx < this.Len(); ok {
		r = this.d[idx]
	}
	return
}

//must get
func (this *IntTreeNodeSortSlice) MustGet(idx int) (r *IntTreeNode) {
	ok := false
	if r, ok = this.Get(idx); !ok {
		panic(idx)
	}
	return
}

//len
func (this *IntTreeNodeSortSlice) Len() int {
	return len(this.d)
}

//sort by Hash decend,the larger one first
func (this *IntTreeNodeSortSlice) Less(i, j int) (ok bool) {
	l, r := (this.d)[i], (this.d)[j]
	return gIntTreeNodeSortSliceGbl.cmp.F(l, r)
}

//swap
func (this *IntTreeNodeSortSlice) Swap(i, j int) {
	(this.d)[i], (this.d)[j] = (this.d)[j], (this.d)[i]
}
