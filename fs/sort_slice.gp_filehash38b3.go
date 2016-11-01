///////////////////////////////////////////////////////////////////
//
// !!!!!!!!!!!! NEVER MODIFY THIS FILE MANUALLY !!!!!!!!!!!!
//
// This file was auto-generated by tool [github.com/vipally/gogp]
// Last update at: [Tue Nov 01 2016 10:50:55]
// Generate from:
//   [github.com/vipally/gx/fs/tree.gp_filehash38b3.go]
//   [github.com/vipally/gx/fs/tree.gpg] [tree_filehash]
//
// Tool [github.com/vipally/gogp] info:
// CopyRight 2016 @Ally Dale. All rights reserved.
// Author  : Ally Dale(vipally@gmail.com)
// Blog    : http://blog.csdn.net/vipally
// Site    : https://github.com/vipally
// BuildAt : [Oct  8 2016 10:34:35]
// Version : 3.0.0.final
//
///////////////////////////////////////////////////////////////////

//this file define a template type for sort

package fs

import "sort"

//func init() {
//	gFileHashSortSliceGbl.cmp = gFileHashSortSliceGbl.cmp.CreateByName("Greater")
//}

//var gFileHashSortSliceGbl struct {
//	cmp CmpFileHash
//}

//new sort object
func NewFileHashSortSlice(capacity int, bigFirst bool) *FileHashSortSlice {
	p := &FileHashSortSlice{}
	p.Init(capacity, bigFirst)
	return p
}

//sort slice
type FileHashSortSlice struct {
	d   []FileHash
	cmp CmpFileHash
}

//init
func (this *FileHashSortSlice) Init(capacity int, bigFirst bool) {
	this.d = make([]FileHash, 0, capacity)
	this.cmp = this.cmp.CreateByBool(bigFirst)
}

//sort
func (this *FileHashSortSlice) Sort() {
	sort.Sort(this)
}

//data buffer
func (this *FileHashSortSlice) Buffer() []FileHash {
	return this.d
}

//push
func (this *FileHashSortSlice) Push(v FileHash) int {
	this.d = append(this.d, v)
	return this.Len()
}

//insert
func (this *FileHashSortSlice) Insert(v FileHash, idx int) int {
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
func (this *FileHashSortSlice) Remove(idx int) (ok bool) {
	if ok = idx >= 0 && idx < this.Len(); ok {
		right := this.d[idx+1:]
		this.d = append(this.d[:idx], right...)
	}
	return
}

//pop
func (this *FileHashSortSlice) Pop() (r FileHash, ok bool) {
	if ok = len(this.d) > 0; ok {
		r = (this.d)[len(this.d)-1]
	}
	this.d = (this.d)[:len(this.d)-1]
	return
}

//len
func (this *FileHashSortSlice) Len() int {
	return len(this.d)
}

//sort by Hash decend,the larger one first
func (this *FileHashSortSlice) Less(i, j int) (ok bool) {
	l, r := (this.d)[i], (this.d)[j]
	return this.cmp.F(l, r)
}

//swap
func (this *FileHashSortSlice) Swap(i, j int) {
	(this.d)[i], (this.d)[j] = (this.d)[j], (this.d)[i]
}
