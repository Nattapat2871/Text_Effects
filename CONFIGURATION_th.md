# การตั้งค่า (Configuration)

แก้ไขไฟล์ `assets/minecraft/shaders/include/_config.glsl` เพื่อปรับแต่งเอฟเฟกต์ตามต้องการ

### ไวยากรณ์พื้นฐาน (Basic Syntax)

```c
TEXT_EFFECT(rgb(R, G, B)) {
    apply_effect();
}
```

### การรองรับรหัสสี Hex (Hex Support)

คุณสามารถใส่รหัสสี Hex ผ่านฟังก์ชันตัวช่วยสีได้ เช่น `rgb(0xRRGGBB)`

> [!TIP]
> สำหรับค่า Hex แบบ 32-bit (รหัส Hex 8 หลัก เช่น `0xRRGGBBAAu` หรือ `0xAARRGGBBu` ที่เป็น RGBA/ARGB) ขอแนะนำอย่างยิ่งให้เติมตัวอักษร `u` ไว้ต่อท้าย เพื่อให้ระบบ GLSL แปลงค่าเป็น unsigned integers อย่างถูกต้อง และป้องกันปัญหาในการคอมไพล์

```c
TEXT_EFFECT(rgb(0xF8F876)) {
    apply_shake();
}

TEXT_EFFECT_WITH_SHADOW(rgb(0xF9F913)) {
    apply_wavy();
    apply_color(rgb(0xFF0000));
}
```

### การรองรับเงาข้อความ (Shadow Support)

> [!WARNING]
> ระบบตรวจจับภายในจะทำการหารค่าสี RGB แต่ละตัวด้วย 4 (และปัดเศษ) เพื่อตรวจดูว่าสีนั้นเป็นเงาหรือไม่
> ดังนั้นจึงขอแนะนำอย่างยิ่งให้ใช้ค่าสี RGB ที่ **หารด้วย 4 ลงตัว** หากคุณตั้งค่าเอฟเฟกต์หลายอันที่ใช้สีใกล้เคียงกันมาก (ต่างกันน้อยกว่า 4) **สีของเงาที่คำนวณได้อาจจะทับซ้อนกัน ทำให้เอฟเฟกต์แสดงผลผิดพลาดได้**

หากต้องการใส่เอฟเฟกต์เดียวกันให้กับทั้งข้อความและเงา:

```c
TEXT_EFFECT_WITH_SHADOW(rgb(255, 255, 86)) {
    apply_shake();
}
```

```c
// เอฟเฟกต์ข้อความหลัก (255, 255, 86)
TEXT_EFFECT(rgb(255, 255, 86)) {
    apply_shake();
}

// เอฟเฟกต์ของเงา (255/4, 255/4, 86/4) = (63, 63, 21)
TEXT_EFFECT(rgb(63, 63, 21)) {
    apply_wavy();
}
```

### ตัวอย่างการใช้งาน (Examples)

```c
// ข้อความสีเหลือง (#FFFF56) แสดงเอฟเฟกต์สั่น
TEXT_EFFECT(rgb(255, 255, 86)) {
    apply_shake();
}

// ผสมเอฟเฟกต์คลื่นและสีรุ้ง
TEXT_EFFECT(rgb(255, 255, 95)) {
    apply_wavy();
    apply_rainbow();
}

// สีที่กำหนดเองพร้อมเอฟเฟกต์สั่นเร็ว
TEXT_EFFECT(rgb(200, 100, 50)) {
    apply_shake(2.0, 1.5);
}
```

### การแสดงผลสี (Display Color)

ใช้ `apply_color()` เพื่อให้ข้อความแสดงสีอื่นที่ต่างจากสีที่ใช้ทริกเกอร์:

```c
// สีที่ใช้เรียกเอฟเฟกต์: (200, 100, 50)
// สีที่แสดงผลจริง: ขาว (255, 255, 255)
TEXT_EFFECT(rgb(200, 100, 50)) {
    apply_shake();
    apply_color(rgb(255, 255, 255));
}
```

สิ่งนี้มีประโยชน์เมื่อคุณต้องการใช้สีเฉพาะเป็นทริกเกอร์ แต่ยังคงต้องการให้ข้อความแสดงผลเป็นสีอื่น

### ฟังก์ชันตัวช่วยสี (Color Helpers)

มีฟังก์ชันช่วย 6 ตัวสำหรับการสร้างเวกเตอร์สีจากชุดตัวเลข:

- `rgb(R, G, B)` → สร้าง `vec3` โดยมีค่า 0..1
- `rgba(R, G, B, A)` → สร้าง `vec4` โดยที่ `A` คือความโปร่งใส (0.0..1.0)
- `argb(A, R, G, B)` → สร้าง `vec4` แบบเอาความโปร่งใสขึ้นก่อน (0.0..1.0)
- `rgb(RGB)` → สร้าง `vec3` ด้วยรหัส Hex
- `rgba(RGBA)` → สร้าง `vec4` ด้วยรหัส Hex (RGBA)
- `argb(ARGB)` → สร้าง `vec4` ด้วยรหัส Hex (ARGB)

```c
apply_color(rgb(255, 80, 80));            // สีแดงทึบ
apply_color(rgb(0x50FF50));               // สีเขียวทึบ
apply_color(rgba(255, 80, 80, 0.5));      // สีแดงโปร่งใส 50%
apply_color(rgba(0x50FF5080u));           // สีเขียวโปร่งใส 50%
apply_color(argb(0x8050FF50u));           // สีเขียวโปร่งใส 50% (alpha ขึ้นก่อน)
apply_gradient(rgba(255, 0, 0, 1.0),
               rgba(0, 0, 255, 0.0), 2.0); // เอฟเฟกต์ไล่สีและเฟดออก
```

เอฟเฟกต์ส่วนใหญ่จะรองรับทั้ง `vec3` (RGB) และ `vec4` (RGBA)

---

### รายละเอียดฟังก์ชันต่างๆ (Detailed Functions)

### `apply_color`

เขียนทับสีข้อความที่แสดงผล (โดยไม่สนใจสีทริกเกอร์ในมาโคร `TEXT_EFFECT(...)`)

- `apply_color(vec3 color)` — เฉพาะ RGB
- `apply_color(vec4 color)` — RGBA รวมถึงความโปร่งใส (0.0–1.0)

```c
TEXT_EFFECT(rgb(200, 100, 50)) {
    apply_shake();
    apply_color(rgb(255, 255, 255));            // ขาวทึบ
}

TEXT_EFFECT(rgb(248, 248, 184)) {
    apply_color(rgba(255, 80, 80, 0.5));        // แดงโปร่งใส 50%
}
```

### `apply_shake(float speed, float intensity)`

ทำให้ข้อความสั่นแบบสุ่ม
- `speed`: ความเร็วในการสั่น
- `intensity`: ระยะการขยับสั่น

### `apply_wavy(float speed, float amplitude, float xFrequency)`

ทำให้ข้อความขยับขึ้นลงเป็นคลื่นไซน์ (Sine wave)
- `speed`: ความเร็วที่คลื่นเคลื่อนที่แนวนอน
- `amplitude`: ความสูง/ต่ำของคลื่น
- `xFrequency`: ความถี่ของคลื่นตามความกว้างข้อความ

### `apply_rainbow(float speed)`

สร้างสีรุ้งเลื่อนไหลต่อเนื่อง
- `speed`: ความเร็วในการเปลี่ยนสี

### `apply_bouncy(float speed, float amplitude)`

ทำให้ข้อความกระเด้งขึ้นและลง
- `speed`: ความเร็วในการกระเด้ง
- `amplitude`: ความสูงสูงสุดของการกระเด้ง

### `apply_blinking(float speed)`

ทำให้ข้อความกระพริบเปิดและปิด (ซ่อนและแสดง)
- `speed`: ความเร็วในการกระพริบ

### `apply_pulse(float speed, float size)`

ทำให้ข้อความขยายและหดอย่างต่อเนื่อง
- `speed`: ความเร็วของการเต้น
- `size`: ขนาดขยายสูงสุด

### `apply_spin(float speed)`

หมุนข้อความทั้งหมดรอบจุดศูนย์กลาง
- `speed`: ความเร็วในการหมุน

### `apply_sequential_spin(float speed)`

หมุนตัวอักษรแต่ละตัวแยกจากกัน
- `speed`: ความเร็วในการหมุน

### `apply_fade(float speed)`

ทำให้ข้อความค่อยๆ โปร่งใสและชัดขึ้น (เฟดเข้า/ออก)
- `speed`: ความเร็วในการเฟด

### `apply_iterating(float speed, float space)`

ทำให้ข้อความกระโดดทีละตัวเหมือนคลื่นเวฟผู้ชม
- `speed`: ความเร็วของคลื่นกระโดด
- `space`: ระยะห่างระหว่างตัวอักษรที่กระโดด

### `apply_glitch(float speed, float intensity)`

ทำให้ตัวอักษรถูกสุ่มย้ายตำแหน่งอย่างรวดเร็ว (ภาพสั่น/ภาพแตกแบบ Glitch)
- `speed`: ความถี่ที่เกิดบั๊กภาพ
- `intensity`: ระยะความผิดเพี้ยนสูงสุด

### `apply_scale(float scale, float offsetX, float offsetY)`

ย่อ/ขยายข้อความ และปรับตำแหน่ง
- `scale`: ตัวคูณขนาดข้อความ (เช่น 1.5 คือ 150%)
- `offsetX` / `offsetY`: การขยับตำแหน่งหลังขยาย

### `apply_offset(float offsetX, float offsetY)`

เลื่อนข้อความโดยไม่เปลี่ยนขนาด
- `offsetX`: ระยะเลื่อนแนวนอน
- `offsetY`: ระยะเลื่อนแนวตั้ง

### `apply_gradient`

ไล่สีแบบคงที่บนตัวอักษร
- `apply_gradient(vec3 startColor, vec3 endColor, float direction)` — RGB.
- `apply_gradient(vec4 startColor, vec4 endColor, float direction)` — RGBA (ผสมรวมกับความโปร่งใส).

`direction` ทิศทาง: `0=↑, 1=↗, 2=→, 3=↘, 4=↓, 5=↙, 6=←, 7=↖`.

```c
apply_gradient(rgb(0, 200, 0), rgb(255, 255, 0), 4.0);
```

### `apply_dynamic_gradient`

ไล่สีแบบเคลื่อนไหวเลื่อนผ่านข้อความเมื่อเวลาผ่านไป
- `apply_dynamic_gradient(vec3 startColor, vec3 endColor, float direction, float speed)`
- `apply_dynamic_gradient(vec4 startColor, vec4 endColor, float direction, float speed)`

```c
apply_dynamic_gradient(rgb(255, 0, 0), rgb(0, 0, 255), 2.0, 500.0);
```

### `apply_lava(float speed)`

การไล่สีอัตโนมัติผสมสีแดงและเหลือง ให้ดูเหมือนลาวาที่กำลังไหล
- `speed`: ความเร็วในการไหลของลาวา

### `apply_aurora`

สีไล่แสงออโรร่าแบบ 3 สี ที่เคลื่อนไหวไหลไปเรื่อยๆ อย่างนุ่มนวล
- `apply_aurora()` — สีเริ่มต้น (ชมพู → เขียว → ฟ้าอ่อน)
- `apply_aurora(float speed)` — กำหนดความเร็วเอง
- `apply_aurora(vec3 c1, vec3 c2, vec3 c3, float speed)` — กำหนดสีและเวลาเองได้
- `apply_aurora(vec4 c1, vec4 c2, vec4 c3, float speed)` — แบบ RGBA

```c
TEXT_EFFECT(rgb(248, 248, 160)) {
    apply_aurora();  
}
```

### `apply_split`

ตัดครึ่งแนวนอนของตัวอักษร และเลื่อนสไลด์ส่วนบนไปมาแบบแอนิเมชันลื่นไหล
- `apply_split()` — ค่าตั้งต้น
- `apply_split(float intensity)` — ขยับพิกเซลเลื่อนของครึ่งบน
- `apply_split(float intensity, float speed)` — ควบคุมความเร็วการสไลด์

```c
TEXT_EFFECT_WITH_SHADOW(rgb(248, 248, 164)) {
    apply_split();
    apply_color(rgb(255, 100, 200));
}
```

### `apply_outline`

วาดขอบเส้นสีรอบๆ ตัวอักษร (ไม่สามารถใช้คู่กับเอฟเฟกต์เปลี่ยนสีรุ้ง/ไล่สีได้)
- `apply_outline()` — ขอบสีดำปกติ หนา 1 พิกเซล
- `apply_outline(vec3 color)` — กำหนดสีขอบเอง
- `apply_outline(vec3 color, float thickness)` — กำหนดสีขอบและความหนาของเส้น
- `apply_outline(vec4 color, float thickness)` — กำหนดด้วย RGBA

### `apply_hatch`

สร้างลวดลายเส้นเฉียงวิ่งพาดผ่านตัวอักษร
- `apply_hatch()` — เส้นขาวปกติ
- `apply_hatch(float speed)` — ปรับความเร็ว
- `apply_hatch(vec3 color, float speed, float density)` — ปรับสี ความเร็ว และความหนาแน่นของลายเส้น

### `apply_neon`

สร้างขอบแสงนีออนนุ่มๆ รอบตัวอักษร พร้อมการกระพริบเบาๆ (ตั้ง speed=0 เพื่อให้สว่างคงที่)
- `apply_neon()` — แสงนีออนสีฟ้า
- `apply_neon(vec3 color, float intensity, float speed)` — ตั้งค่าสี, ความแรงแสง, และความเร็วกระพริบ

### `apply_chromatic`

เอฟเฟกต์สีเลื่อมๆ แนว 3D ที่ขอบภาพ แตกสีแดง-เขียว-น้ำเงิน ออกจากกัน
- `apply_chromatic()` — ค่าปกติ
- `apply_chromatic(float intensity, float speed)` — ระยะยืดสีและความเร็ว

### `apply_extrude`

ซ้อนเงาด้านล่างขวาเพื่อสร้างมิติภาพนูน 3D หรือเงาลึก
- `apply_extrude()` — ลึก 1 เลเยอร์ซ้อน 3 ชั้น
- `apply_extrude(float depth, float layers)` — ปรับระยะเงาและจำนวนชั้นเงา (สูงสุด 16)
- `apply_extrude(float depth, float layers, vec3 endColor)` — ไล่สีเงาจากสีตัวหนังสือไปยังสี endColor

### `apply_noise`

สุ่มบิดเบี้ยวข้อความด้วยสัญญาณรบกวนเหมือนทีวีซ่า
- `apply_noise(float intensity, float speed)` — รัศมีการย้ายตำแหน่งและความถี่

### `apply_liquid`

บิดเบี้ยวให้ดูเหมือนข้อความจมอยู่ในน้ำหรือของเหลว
- `apply_liquid(float intensity, float speed)` — รัศมีและความเร็วคลื่นของเหลว

### `apply_water`

เอฟเฟกต์น้ำไหลเติมเข้าไปในตัวอักษรตามระดับที่กำหนด
- `apply_water()` — น้ำสีฟ้า 55%
- `apply_water(vec3 color, float level, float amplitude, float speed, float frequency)` — กำหนดสีน้ำ, ระดับน้ำ (0.0-1.0), ความแรงคลื่น, ความเร็ว, และความถี่คลื่น

```c
// น้ำสีฟ้า เติมที่ 55% ปกติ
TEXT_EFFECT(rgb(248, 248, 212)) {
    apply_water(rgb(40, 150, 240));
    apply_color(rgb(60, 60, 80));   // ส่วนที่แห้งเหนือน้ำ
}
```
