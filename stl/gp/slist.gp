//#GOGP_IGNORE_BEGIN
///////////////////////////////////////////////////////////////////
//
// !!!!!!!!!!!! NEVER MODIFY THIS FILE MANUALLY !!!!!!!!!!!!
//
// This file was auto-generated by tool [github.com/vipally/gogp]
// Last update at: [Sat Apr 01 2017 22:48:08]
// Generate from:
//   [github.com/vipally/gx/stl/gp/slist.gp.go]
//   [github.com/vipally/gx/stl/gp/gp.gpg] [GOGP_REVERSE_slist]
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
//#GOGP_IGNORE_END

<PACKAGE>

//#GOGP_REQUIRE(github.com/vipally/gogp/lib/fakedef,_)

//#GOGP_REQUIRE(github.com/vipally/gx/stl/gp/functorcmp)

////////////////////////////////////////////////////////////////////////////////

var g<GLOBAL_NAME_PREFIX>SListGbl struct {
	cmp Cmp<GLOBAL_NAME_PREFIX>
}

func init() {
	g<GLOBAL_NAME_PREFIX>SListGbl.cmp = g<GLOBAL_NAME_PREFIX>SListGbl.cmp.CreateByName("#GOGP_GPGCFG(GOGP_DefaultCmpType)")
}

//list node
type <GLOBAL_NAME_PREFIX>SListNode struct {
	val  <VALUE_TYPE>
	next *<GLOBAL_NAME_PREFIX>SListNode
}

func (this *<GLOBAL_NAME_PREFIX>SListNode) Get() <VALUE_TYPE> {
	return this.val
}

func (this *<GLOBAL_NAME_PREFIX>SListNode) Set(v <VALUE_TYPE>) (old <VALUE_TYPE>) {
	old, this.val = this.val, v
	return
}

func (this *<GLOBAL_NAME_PREFIX>SListNode) Tail() (r *<GLOBAL_NAME_PREFIX>SListNode, size int) {
	if this != nil {
		for r, size = this, 1; r != nil && r.next != nil; r, size = r.next, size+1 { //do nothing body
		}
	}
	return
}

func (this *<GLOBAL_NAME_PREFIX>SListNode) Next() (r *<GLOBAL_NAME_PREFIX>SListNode) {
	if this != nil {
		r = this.next
	}
	return
}

type <GLOBAL_NAME_PREFIX>SListNodeVisitor struct {
	node, head *<GLOBAL_NAME_PREFIX>SListNode
}

func (this *<GLOBAL_NAME_PREFIX>SListNodeVisitor) Next() (ok bool) {
	if this.node == nil {
		if ok = this.head != nil; ok {
			this.node = this.head
		}
	} else {
		this.node = this.node.next
		ok = this.node != nil
	}
	return false
}

func (this *<GLOBAL_NAME_PREFIX>SListNodeVisitor) Get() *<GLOBAL_NAME_PREFIX>SListNode {
	return this.node
}

//single-way link list object
type <GLOBAL_NAME_PREFIX>SList struct {
	head <GLOBAL_NAME_PREFIX>SListNode //head is a dummy node, not a pionter
	//#GOGP_IFDEF GOGP_HasTail
	tail *<GLOBAL_NAME_PREFIX>SListNode //
	//#GOGP_ENDIF

	//GOGP_HasTail
	//bug: ring?
}

//new object
func New<GLOBAL_NAME_PREFIX>SList() *<GLOBAL_NAME_PREFIX>SList {
	return &<GLOBAL_NAME_PREFIX>SList{}
}

func (this *<GLOBAL_NAME_PREFIX>SList) Empty() bool {
	return this.head.next != nil
}

func (this *<GLOBAL_NAME_PREFIX>SList) Len() (n int) {
	for v := this.Visitor(); v.Next(); n++ {
	}
	return
}

func (this *<GLOBAL_NAME_PREFIX>SList) Visitor() *<GLOBAL_NAME_PREFIX>SListNodeVisitor {
	v := &<GLOBAL_NAME_PREFIX>SListNodeVisitor{node: nil, head: this.head.next}
	return v
}

func (this *<GLOBAL_NAME_PREFIX>SList) Front() *<GLOBAL_NAME_PREFIX>SListNode {
	return this.head.next
}

//#GOGP_IFDEF GOGP_HasTail
func (this *<GLOBAL_NAME_PREFIX>SList) Back() *<GLOBAL_NAME_PREFIX>SListNode {
	return this.tail
} //
//#GOGP_ENDIF

func (this *<GLOBAL_NAME_PREFIX>SList) Clear() {
	this.head.next = nil
	//#GOGP_IFDEF GOGP_HasTail
	this.tail = nil //
	//#GOGP_ENDIF
}

func (this *<GLOBAL_NAME_PREFIX>SList) PushFront(v <VALUE_TYPE>) *<GLOBAL_NAME_PREFIX>SListNode {
	n := &<GLOBAL_NAME_PREFIX>SListNode{val: v, next: this.head.next}
	this.head.next = n
	//#GOGP_IFDEF GOGP_HasTail
	if this.tail == nil {
		this.tail = n
	} //
	//#GOGP_ENDIF
	return n
}

func (this *<GLOBAL_NAME_PREFIX>SList) PopFront() (v <VALUE_TYPE>, ok bool) {
	if n := this.Remove(this.Front()); n != nil {
		v, ok = n.Get(), true
	}
	return
}

//#GOGP_IFDEF GOGP_HasTail
func (this *<GLOBAL_NAME_PREFIX>SList) PopBack() (v <VALUE_TYPE>, ok bool) {
	if n := this.Remove(this.Back()); n != nil {
		v, ok = n.Get(), true
	}
	return
} //
//#GOGP_ENDIF

//#GOGP_IFDEF GOGP_HasTail
func (this *<GLOBAL_NAME_PREFIX>SList) PushBack(v <VALUE_TYPE>) *<GLOBAL_NAME_PREFIX>SListNode {
	n := &<GLOBAL_NAME_PREFIX>SListNode{val: v}
	if this.tail != nil {
		this.tail.next = n
	} else {
		this.head.next = n
	}
	this.tail = n
	return n
} //
//#GOGP_ENDIF

func (this *<GLOBAL_NAME_PREFIX>SList) PushFrontList(other *<GLOBAL_NAME_PREFIX>SList) {
	var t *<GLOBAL_NAME_PREFIX>SListNode
	//#GOGP_IFDEF GOGP_HasTail
	t = other.tail
	//#GOGP_ELSE
	t, _ = other.head.next.Tail()
	//#GOGP_ENDIF
	if t != nil {
		t.next = this.head.next
		this.head.next = other.head.next
		//#GOGP_IFDEF GOGP_HasTail
		if this.tail == nil {
			this.tail = t
		} //
		//#GOGP_ENDIF
	}
}

//#GOGP_IFDEF GOGP_HasTail
func (this *<GLOBAL_NAME_PREFIX>SList) PushBackList(other *<GLOBAL_NAME_PREFIX>SList) {
	if other.tail != nil {
		if this.tail != nil {
			this.tail.next = other.head.next
			this.tail = other.tail
		} else {
			this.head.next, this.tail = other.head.next, other.tail
		}
		other.Clear()
	}
} //
//#GOGP_ENDIF

//func (this *GOGPListNamePrefixSList) InsertBefore(v <VALUE_TYPE>, mark *<GLOBAL_NAME_PREFIX>SListNode) *<GLOBAL_NAME_PREFIX>SListNode {
//	return nil
//}

func (this *<GLOBAL_NAME_PREFIX>SList) PushAfter(v <VALUE_TYPE>, mark *<GLOBAL_NAME_PREFIX>SListNode) (n *<GLOBAL_NAME_PREFIX>SListNode) {
	if mark != nil {
		n = &<GLOBAL_NAME_PREFIX>SListNode{val: v, next: mark.next}
		n = this.InsertAfter(n, mark)
	}
	return
}

func (this *<GLOBAL_NAME_PREFIX>SList) InsertAfter(node, mark *<GLOBAL_NAME_PREFIX>SListNode) (n *<GLOBAL_NAME_PREFIX>SListNode) {
	if mark != nil && node != nil && node != mark {
		node.next = mark.next
		mark.next = node
		n = node
	}
	return
}

func (this *<GLOBAL_NAME_PREFIX>SList) InsertFront(node *<GLOBAL_NAME_PREFIX>SListNode) (n *<GLOBAL_NAME_PREFIX>SListNode) {
	n = this.InsertAfter(node, &this.head)
	return
}

func (this *<GLOBAL_NAME_PREFIX>SList) RemoveFront() (n *<GLOBAL_NAME_PREFIX>SListNode) {
	n = this.Remove(this.head.next)
	return
}

func (this *<GLOBAL_NAME_PREFIX>SList) Remove(node *<GLOBAL_NAME_PREFIX>SListNode) (r *<GLOBAL_NAME_PREFIX>SListNode) {
	if node != nil {
		for b := &this.head; b.next != nil; b = b.next {
			if b.next == node {
				b.next = node.next
				node.next = nil
				r = node
				break
			}
		}
	}
	return
}

func (this *<GLOBAL_NAME_PREFIX>SList) MoveFront(node *<GLOBAL_NAME_PREFIX>SListNode) (r *<GLOBAL_NAME_PREFIX>SListNode) {
	if node != nil {
		for b := this.head.next; b != nil; b = b.next {
			if b.next == node {
				b.next = node.next
				node.next = this.head.next
				this.head.next = node
				r = node
				//#GOGP_IFDEF GOGP_HasTail
				if this.tail == node {
					this.tail = b
				} //
				//#GOGP_ENDIF
				break
			}
		}
	}
	return
}

//#GOGP_IFDEF GOGP_HasTail
func (this *<GLOBAL_NAME_PREFIX>SList) MoveBack(node *<GLOBAL_NAME_PREFIX>SListNode) (r *<GLOBAL_NAME_PREFIX>SListNode) {
	if node != nil && node.next != nil {
		for b := this.head.next; b != nil; b = b.next {
			if b.next == node {
				b.next = node.next
				node.next = nil
				this.tail.next = node
				this.tail = node
				r = node
				break
			}
		}
	}
	return
} //
//#GOGP_ENDIF

//func (this *GOGPListNamePrefixSList) MoveBefore(node, mark *<GLOBAL_NAME_PREFIX>SListNode) *<GLOBAL_NAME_PREFIX>SListNode {
//	return nil
//}

func (this *<GLOBAL_NAME_PREFIX>SList) MoveAfter(node, mark *<GLOBAL_NAME_PREFIX>SListNode) (r *<GLOBAL_NAME_PREFIX>SListNode) {
	if node != nil && mark != nil && node != mark {
		for b := &this.head; b != nil; b = b.next { //bug:tail?
			if b.next == node {
				if b != mark {
					b.next = node.next
					node.next = mark.next
					mark.next = node
					r = node
					//#GOGP_IFDEF GOGP_HasTail
					if this.tail == node {
						this.tail = b
					} //
					//#GOGP_ENDIF
				}
				break
			}
		}
	}
	return
}

func (this *<GLOBAL_NAME_PREFIX>SList) Reverse() {
	p := this.head.next
	this.Clear()
	//#GOGP_IFDEF GOGP_HasTail
	this.tail = p //
	//#GOGP_ENDIF
	for p != nil {
		q := p.next
		this.InsertFront(p)
		p = q
	}
}

func (this *<GLOBAL_NAME_PREFIX>SList) HasCycle(head *<GLOBAL_NAME_PREFIX>SListNode) (ok bool) {
	for slow, fast := head, head; fast != nil; fast, slow = fast.next.next, slow.next { //do nothing body
		fast = fast.next
		if ok = fast != nil; !ok {
			break
		}
		fast = fast.next
		slow = slow.next
		if ok = fast == slow; ok {
			break
		}
	}
	return
}

//func (this *<GLOBAL_NAME_PREFIX>SList) FindCycleStart() *<GLOBAL_NAME_PREFIX>SListNode { return nil }

//func (this *<GLOBAL_NAME_PREFIX>DList) Find(v <VALUE_TYPE>) *<GLOBAL_NAME_PREFIX>SListNode {
//	return nil
//}

func (this *<GLOBAL_NAME_PREFIX>SList) Reachable(node, dest *<GLOBAL_NAME_PREFIX>SListNode) (ok bool) {
	if ok = (node == dest) && node != nil; !ok && node != nil && dest != nil {
		for p := node; p != nil && p != node; p = p.next {
			if ok = (p == dest); ok {
				break
			}
		}
	}
	return
}

func (this *<GLOBAL_NAME_PREFIX>SList) IsValidNode(node *<GLOBAL_NAME_PREFIX>SListNode) bool {
	return this.Reachable(this.head.next, node)
}

//merge sort
func (this *<GLOBAL_NAME_PREFIX>SList) Sort() {
	if nil == this.head.next || nil == this.head.next.next { //0 or 1 element, no need to sort
		return
	}
	this.mergeSort()
}

//STL's merge sort algorithm for list
func (this *<GLOBAL_NAME_PREFIX>SList) mergeSort() {
	var (
		hand, unsorted <GLOBAL_NAME_PREFIX>SList
		binList        [64]<GLOBAL_NAME_PREFIX>SList //save temp list that len=2^i
		nFilledBin     = 0
	)

	for unsorted = *this; !unsorted.Empty(); {
		hand.InsertFront(unsorted.RemoveFront())
		i := 0
		for ; i < nFilledBin && !binList[i].Empty(); i++ {
			binList[i].merge(&hand)
			hand, binList[i] = binList[i], hand
		}
		hand, binList[i] = binList[i], hand
		if i == nFilledBin {
			nFilledBin++
		}
	}

	for i := 1; i < nFilledBin; i++ {
		binList[i].merge(&binList[i-1])
	}

	*this = binList[nFilledBin-1]
	//#GOGP_IFDEF GOGP_HasTail
	this.tail, _ = this.head.next.Tail() //
	//#GOGP_ENDIF
}

//merge other sorted-list  to this sorted-list
func (this *<GLOBAL_NAME_PREFIX>SList) merge(other *<GLOBAL_NAME_PREFIX>SList) {
	p, po := &this.head, other.Front()
	for p.next != nil && po != nil {
		pn := p.next
		if g<GLOBAL_NAME_PREFIX>SListGbl.cmp.F(po.val, pn.val) {
			n := other.RemoveFront()
			po = other.Front()
			p = this.InsertAfter(n, p)
		} else {
			p = p.next
		}
	}
	if po != nil {
		p.next = po
		other.Clear()
		//#GOGP_IFDEF GOGP_HasTail
		this.tail = other.tail //
		//#GOGP_ENDIF
	}
}

//func (this *<GLOBAL_NAME_PREFIX>SList) merge(a, b *<GLOBAL_NAME_PREFIX>SListNode) *<GLOBAL_NAME_PREFIX>SListNode {
//	if a == nil {
//		return b
//	} else if b == nil {
//		return a
//	}
//	var (
//		head <GLOBAL_NAME_PREFIX>SListNode
//		tail *<GLOBAL_NAME_PREFIX>SListNode
//	)
//	for tail = &head; a != nil && b != nil; {
//		if g<GLOBAL_NAME_PREFIX>SListGbl.cmp.F(a.<VALUE_TYPE>, b.<VALUE_TYPE>) {
//			tail.next = a
//			tail = tail.next
//			a = a.next
//		} else {
//			tail.next = b
//			tail = tail.next
//			b = b.next
//		}
//	}
//	if a != nil {
//		tail.next = a
//		tail, _ = a.Tail()
//	} else if b != nil {
//		tail.next = b
//		tail, _ = b.Tail()
//	}
//	tail.next = nil

//	return head.next
//}

//func (this *<GLOBAL_NAME_PREFIX>SList) mid(head *<GLOBAL_NAME_PREFIX>SListNode) *<GLOBAL_NAME_PREFIX>SListNode {
//	if head == nil || head.next == nil {
//		return head
//	}
//	slow := head
//	for fast := head; fast != nil && fast.next != nil; fast, slow = fast.next.next, slow.next { //do nothing body
//	}
//	return slow
//}

//func (this *<GLOBAL_NAME_PREFIX>SList) mergeSort(head *<GLOBAL_NAME_PREFIX>SListNode) *<GLOBAL_NAME_PREFIX>SListNode {
//	if head == nil || head.next == nil {
//		return head
//	} else if mid := this.mid(head); mid != nil {
//		midNext := mid.next
//		mid.next = nil
//		return this.merge(this.mergeSort(mid), this.mergeSort(midNext))
//	}
//	return nil
//}

//func (this *<GLOBAL_NAME_PREFIX>SList) PushOrderly(v <VALUE_TYPE>) *<GLOBAL_NAME_PREFIX>SListNode {
//	n := &<GLOBAL_NAME_PREFIX>SListNode{<VALUE_TYPE>: v, next: nil}
//	return this.InsertOrderly(n)
//}

//func (this *<GLOBAL_NAME_PREFIX>SList) InsertOrderly(node *<GLOBAL_NAME_PREFIX>SListNode) *<GLOBAL_NAME_PREFIX>SListNode {
//	p := &this.head
//	for ; p.next != nil; p = p.next {
//		if n := p.next; g<GLOBAL_NAME_PREFIX>SListGbl.cmp.F(node.<VALUE_TYPE>, n.<VALUE_TYPE>) {
//			break
//		}
//	}
//	node.next = p.next
//	p.next = node
//	//#GOGP_IFDEF GOGP_HasTail
//	if this.tail == nil || this.tail == p {
//		this.tail = node
//	} //
//	//#GOGP_ENDIF
//	return node
//}

//func (this *<GLOBAL_NAME_PREFIX>SList) insertSort(head *<GLOBAL_NAME_PREFIX>SListNode) *<GLOBAL_NAME_PREFIX>SListNode {
//	if head == nil || head.next == nil {
//		return head
//	}

//	var h <GLOBAL_NAME_PREFIX>SList
//	for p := head; p != nil; {
//		q := p.next
//		p.next = nil
//		h.InsertOrderly(p)
//		p = q
//	}
//	return h.head.next
//}

