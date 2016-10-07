///////////////////////////////////////////////////////////////////
//
// !!!!!!!!!!!! NEVER MODIFY THIS FILE MANUALLY !!!!!!!!!!!!
//
// This file was auto-generated by tool [github.com/vipally/gogp]
// Last update at: [Fri Oct 07 2016 17:37:46]
// Generate from:
//   [github.com/vipally/gx/regable/reg.gp]
//   [github.com/vipally/gx/regable/reg.gpg] [uint64]
//
// Tool [github.com/vipally/gogp] info:
// CopyRight 2016 @Ally Dale. All rights reserved.
// Author  : Ally Dale(vipally@gmail.com)
// Blog    : http://blog.csdn.net/vipally
// Site    : https://github.com/vipally
// BuildAt : [Oct  6 2016 14:25:07]
// Version : 3.0.0.final
// 
///////////////////////////////////////////////////////////////////

package regable

import (
	"bytes"
	"fmt"
	"sync"
	"github.com/vipally/gx/consts"
	"github.com/vipally/gx/errors"
	xmath "github.com/vipally/gx/math"
)

const (
	default_u64_reg_cnt = 1024
)

var (
	g_u64_rgr_id_gen, _         = amath.NewRangeUint32(g_invalid_id+1, g_invalid_id, g_max_reger_id)
	errid_u64_id, _  = aerr.Reg("Uint64Id error")
	errid_u64_obj, _ = aerr.Reg("Uint64 object error")
)

var (
	g_u64_reger_list []*Uint64Reger
)

func init() {
	reg_show(ShowAllUint64Regers)
}

//new reger
func NewUint64Reger(name string) (r *Uint64Reger, err error) {
	defer func() {
		if err != nil {
			panic(err)
		}
	}()
	if err = check_lock(); err != nil {
		return
	}
	id := g_invalid_id
	if id, err = g_u64_rgr_id_gen.Inc(); err != nil {
		return
	}
	p := new(Uint64Reger)
	if err = p.init(name); err == nil {
		p.reger_id = uint8(id)
		r = p
		g_u64_reger_list = append(g_u64_reger_list, p)
	}
	return
}

func MustNewUint64Reger(name string) (r *Uint64Reger) {
	if reg, err := NewUint64Reger(name); err != nil {
		panic(err)
	} else {
		r = reg
	}
	return
}

//show all regers
func ShowAllUint64Regers() string {
	var buf bytes.Buffer
	s := fmt.Sprintf("[Uint64Regers] count:%d", len(g_u64_reger_list))
	buf.WriteString(s)
	for _, v := range g_u64_reger_list {
		buf.WriteString(consts.NewLine)
		buf.WriteString(v.String())
	}
	return buf.String()
}

//reger object
type Uint64Reger struct {
	reger_id uint8
	name     string
	id_gen   amath.RangeUint32
	reg_list []*_uint64Record
}

func (me *Uint64Reger) init(name string) (err error) {
	me.name = name
	if err = me.id_gen.Init(g_invalid_id+1, g_invalid_id,
		g_invalid_id+default_u64_reg_cnt); err != nil {
		return
	}
	me.reg_list = make([]*_uint64Record, 0, 0)
	return
}

//set max reg count at a reger
func (me *Uint64Reger) MaxReg(max_regs uint32) (rmax uint32, err error) {
	if err = verify_max_regs(max_regs); err != nil {
		return
	}
	cur, min, _ := me.id_gen.Get()
	if err = me.id_gen.Init(cur, min, g_invalid_id+max_regs); err != nil {
		return
	}
	rmax = me.id_gen.Max()
	return
}

//reg a value
func (me *Uint64Reger) Reg(name string, val uint64) (r Uint64Id, err error) {
	r = Uint64Id(g_invalid_id)
	defer func() {
		if err != nil {
			panic(err)
		}
	}()
	id := g_invalid_id
	if err = check_lock(); err != nil {
		return
	}
	if id, err = me.id_gen.Inc(); err != nil {
		return
	}
	p := me.new_rec(name, val)
	p.id = id
	me.reg_list = append(me.reg_list, p)
	r = Uint64Id(MakeRegedId(uint32(me.reger_id), id))
	return
}

func (me *Uint64Reger) MustReg(name string, val uint64) (r Uint64Id) {
	if reg, err := me.Reg(name, val); err != nil {
		panic(err)
	} else {
		r = reg
	}
	return
}

//show string
func (me *Uint64Reger) String() string {
	var buf bytes.Buffer
	s := fmt.Sprintf("[Uint64Reger#%d: %s] ids:%s",
		me.reger_id, me.name, me.id_gen.String())
	buf.WriteString(s)
	for i, v := range me.reg_list {
		v.lock.RLock()
		s = fmt.Sprintf("\n#%d [%s]: %v",
			uint32(i)+g_invalid_id+1, v.name,
			v.val)
		v.lock.RUnlock()
		buf.WriteString(s)
	}
	return buf.String()
}

type _uint64Record struct {
	name string
	val  uint64
	id   uint32
	lock sync.RWMutex
}

func (me *Uint64Reger) new_rec(name string, val uint64) (r *_uint64Record) {
	r = new(_uint64Record)
	r.name = name
	r.val = val
	return
}

type Uint64Id regedId

func (cp Uint64Id) get() (rg *Uint64Reger, r *_uint64Record, err error) {
	idrgr, id := regedId(cp).ids()
	idregidx, idx := idrgr-g_invalid_id-1, id-g_invalid_id-1
	if idrgr == g_invalid_id || !g_u64_rgr_id_gen.InCurrentRange(idrgr) {
		err = aerr.New(errid_u64_id)
	}
	rg = g_u64_reger_list[idregidx]
	if id == g_invalid_id || !rg.id_gen.InCurrentRange(id) {
		err = aerr.New(errid_u64_id)
	}
	r = rg.reg_list[idx]
	return
}

//check if valid
func (cp Uint64Id) Valid() (rvalid bool) {
	if _, _, e := cp.get(); e == nil {
		rvalid = true
	}
	return
}

//get value
func (cp Uint64Id) Get() (r uint64, err error) {
	_, rc, e := cp.get()
	if e != nil {
		return r, e
	}
	return rc.Get()
}

//get value with out error, if has error will cause panic
func (cp Uint64Id) GetNoErr() (r uint64) {
	_, rc, e := cp.get()
	if e != nil {
		panic(e.Error())
	}
	return rc.GetNoErr()
}

//set value
func (cp Uint64Id) Set(val uint64) (r uint64, err error) {
	_, rc, e := cp.get()
	if e != nil {
		return r, e
	}
	return rc.Set(val)
}

//reverse bool value(as a switch)
//func (cp Uint64Id) Reverse() (r uint64, err error) {
//	_, rc, e := cp.get()
//	if e != nil {
//		return r, e
//	}
//	return rc.Reverse()
//}

//get reger_id and real_id
func (cp Uint64Id) Ids() (reger_id, real_id uint32) {
	return regedId(cp).ids()
}

//show string
func (cp Uint64Id) String() (r string) {
	idrgr, id := regedId(cp).ids()
	_, rc, err := cp.get()
	if err != nil {
		r = fmt.Sprintf("invalid Uint64Id#(%d|%d)", idrgr, id)
	} else {
		r = rc.String()
	}
	return
}

//get name

func (cp Uint64Id) Name() (r string, err error) {
	_, rc, e := cp.get()
	if e == nil {
		r, err = rc.Name()
	} else {
		err = e
	}
	return
}


//get as object for fast access
func (cp Uint64Id) Oject() (r Uint64Obj) {
	_, rc, e := cp.get()
	if e == nil {
		r.obj = rc
	}
	return
}

//get name

func (me *_uint64Record) Name() (r string, err error) {
	if me != nil {
		me.lock.RLock()
		defer me.lock.RUnlock()
		r = me.name
	} else {
		err = aerr.New(errid_u64_obj)
	}
	return
}


//get value
func (me *_uint64Record) Get() (r uint64, err error) {
	if me != nil {
		me.lock.RLock()
		defer me.lock.RUnlock()
		r = me.val
	} else {
		err = aerr.New(errid_u64_obj)
	}
	return
}

//get value without error,if has error will cause panic
func (me *_uint64Record) GetNoErr() (r uint64) {
	r0, err := me.Get()
	if err != nil {
		panic(err.Error())
	}
	r = r0
	return
}

//set value
func (me *_uint64Record) Set(val uint64) (r uint64, err error) {
	if nil != me {
		me.lock.Lock()
		defer me.lock.Unlock()
		me.val = val
		r = val
	} else {
		err = aerr.New(errid_u64_obj)
	}
	return
}

//reverse on bool value
//func (me *_uint64Record) Reverse() (r uint64, err error) {
//	if nil != me {
//		me.lock.Lock()
//		defer me.lock.Unlock()
//		me.val = !me.val
//		r = me.val
//	} else {
//		err = aerr.New(errid_u64_obj)
//	}
//	return
//}

//get as Id
func (me *_uint64Record) Id() (r Uint64Id) {
	if me != nil {
		r = Uint64Id(me.id)
	}
	return
}

//show string
func (me *_uint64Record) String() (r string) {
	if me != nil {
		idrgr, id := regedId(me.id).ids()
		me.lock.RLock()
		defer me.lock.RUnlock()
		r = fmt.Sprintf("Uint64#(%d|%d|%s)%v", idrgr, id, me.name, me.val)
	} else {
		r = fmt.Sprintf("invalid uint64 object")
	}
	return
}

//object of reged value,it is more efficient to access than Id object
type Uint64Obj struct {
	obj *_uint64Record
}

//check if valid
func (cp Uint64Obj) Valid() (rvalid bool) {
	return cp.obj != nil
}

//get value
func (cp Uint64Obj) Get() (r uint64, err error) {
	return cp.obj.Get()
}

//get value against error,if has error will cause panic
func (cp Uint64Obj) GetNoErr() (r uint64) {
	return cp.obj.GetNoErr()
}

//set value
func (cp Uint64Obj) Set(val uint64) (r uint64, err error) {
	return cp.obj.Set(val)
}

//reverse bool object
//func (cp Uint64Obj) Reverse() (r uint64, err error) {
//	return cp.obj.Reverse()
//}

//show string
func (cp Uint64Obj) String() (r string) {
	return cp.obj.String()
}

//get name

func (cp Uint64Obj) Name() (r string, err error) {
	return cp.obj.Name()
}


//get as Id
func (cp Uint64Obj) Id() (r Uint64Id) {
	return cp.obj.Id()
}

//reg and return an object agent
func (me *Uint64Reger) RegO(name string, val uint64) (r Uint64Obj, err error) {
	id, e := me.Reg(name, val)
	if e == nil {
		r = id.Oject()
	} else {
		err = e
	}
	return
}

func (me *Uint64Reger) MustRegO(name string, val uint64) (r Uint64Obj) {
	if reg, err := me.RegO(name, val); err != nil {
		panic(err)
	} else {
		r = reg
	}
	return
}
