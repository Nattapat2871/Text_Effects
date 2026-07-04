# TheSalt's Text Effects (เอฟเฟกต์ข้อความของ TheSalt)

เพิ่มแอนิเมชันข้อความแบบเคลื่อนไหว (Dynamic text animations) ให้กับโลก Minecraft ของคุณ! Resource Pack นี้ให้บริการ **เอฟเฟกต์ข้อความที่ปรับแต่งได้** สามารถใช้ร่วมกับคำสั่ง `/title`, `/tellraw` และองค์ประกอบข้อความอื่นๆ ที่คล้ายคลึงกัน

> Resource Pack นี้ **ไม่สามารถใช้งานร่วมกับ** Pack อื่นที่มีการแก้ไข Core shader ส่วน `rendertype_text` ได้

## วิธีการทำงาน

คุณสามารถกำหนดการจับคู่สีกับเอฟเฟกต์ได้ในไฟล์ `_config.glsl` เมื่อใดก็ตามที่ข้อความมีการใช้สี RGB ที่ตรงกัน เอฟเฟกต์ที่ถูกตั้งค่าไว้จะแสดงผลขึ้นมาทันที

## ภาพตัวอย่าง

![23](https://github.com/user-attachments/assets/1ed9fd46-a769-4256-bc36-758adc431602)

<img width="1228" height="668" alt="new1" src="https://github.com/user-attachments/assets/fd819652-8fa1-41ab-b177-50e09646ea2d" />

<img width="1920" height="1009" alt="2026-03-08_22 50 06" src="https://github.com/user-attachments/assets/3c988bdb-a60d-4db7-ba49-a50a3ab8f918" />

<img width="1920" height="1009" alt="2026-03-08_22 49 24" src="https://github.com/user-attachments/assets/a4d76af1-aae6-4132-b3ac-4e39eb6344f9" />

## สามารถนำไปใช้ในแมพหรือเซิร์ฟเวอร์ของตัวเองได้หรือไม่?

ได้แน่นอน แต่มีข้อแม้ว่าคุณจะต้องเก็บไฟล์ [license](./LICENSE) ไว้ภายใน Resource Pack เสมอ และต้องเพิ่มข้อความ `Credit. TheSalt's Text Effects` ลงในคำอธิบายในไฟล์ `pack.mcmeta`

## เอฟเฟกต์ที่มีให้ใช้งาน

| เอฟเฟกต์                                                                                                                                                                 | คำอธิบาย                  |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------- |
| [`apply_shake(speed, intensity)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_shakefloat-speed-float-intensity)                            | สั่นแบบสุ่ม               |
| [`apply_wavy(speed, amplitude, xFrequency)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_wavyfloat-speed-float-amplitude-float-xfrequency) | แอนิเมชันคลื่น            |
| [`apply_rainbow(speed)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_rainbowfloat-speed)                                                   | หมุนเวียนสีรุ้ง           |
| [`apply_bouncy(speed, amplitude)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_bouncyfloat-speed-float-amplitude)                          | แอนิเมชันกระเด้ง          |
| [`apply_blinking(speed)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_blinkingfloat-speed)                                                 | กระพริบ เปิด/ปิด          |
| [`apply_pulse(speed, size)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_pulsefloat-speed-float-size)                                      | แอนิเมชันขยาย/หด          |
| [`apply_spin(speed)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_spinfloat-speed)                                                         | หมุน                      |
| [`apply_sequential_spin(speed)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_sequential_spinfloat-speed)                                   | หมุนตัวอักษรทีละตัว       |
| [`apply_fade(speed)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_fadefloat-speed)                                                         | เฟดเข้า/ออก               |
| [`apply_iterating(speed, space)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_iteratingfloat-speed-float-space)                            | กระโดดทีละตัวต่อเนื่อง    |
| [`apply_glitch(speed, intensity)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_glitchfloat-speed-float-intensity)                          | สั่นและกระตุกแบบสุ่ม (Glitch) |
| [`apply_scale(scale, offsetX, offsetY)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_scalefloat-scale-float-offsetx-float-offsety)         | ย่อขยายข้อความ            |
| [`apply_offset(offsetX, offsetY)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_offsetfloat-offsetx-float-offsety)                          | ย้ายตำแหน่งข้อความ        |
| [`apply_gradient(startColor, endColor, direction)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_gradient)                                  | ไล่สีแบบคงที่             |
| [`apply_dynamic_gradient(start, end, dir, speed)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_dynamic_gradient)                           | ไล่สีแบบเคลื่อนไหว        |
| [`apply_lava(speed)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_lavafloat-speed)                                                         | เอฟเฟกต์ลาวาไหล           |
| [`apply_color(color)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_color)                                                                  | เขียนทับสีที่แสดงผล       |
| [`apply_aurora(c1, c2, c3, speed)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_aurora)                                                    | เอฟเฟกต์แสงออโรร่า 3 สีไหล|
| [`apply_split(intensity, speed)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_split)                                                       | แบ่งครึ่งแนวนอนเคลื่อนไหว |
| [`apply_outline(color, thickness)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_outline)                                                   | วาดขอบตัวอักษร (fragment) |
| [`apply_hatch(color, speed, density)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_hatch)                                                  | แถบลายเฉียง (fragment)    |
| [`apply_neon(color, intensity, speed)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_neon)                                                  | เรืองแสงนีออน (fragment)  |
| [`apply_chromatic(intensity, speed)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_chromatic)                                               | ขอบสีรุ้งเหลื่อมๆ (fragment) |
| [`apply_extrude(depth, layers)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_extrude)                                                      | เงาสามมิติ (fragment)     |
| [`apply_noise(intensity, speed)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_noise)                                                       | คลื่นรบกวน/ภาพซ่า (fragment) |
| [`apply_liquid(intensity, speed)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_liquid)                                                     | บิดเบี้ยวแบบของเหลว (frag) |
| [`apply_water(color, level, amp, speed)`](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION.md#apply_water)                                               | แอนิเมชันเติมน้ำในตัวอักษร|

---

## การตั้งค่า

สามารถเข้าไปดูที่ไฟล์ [CONFIGURATION_th.md](https://github.com/TheSalts/Text_Effects/blob/main/CONFIGURATION_th.md) เพื่อศึกษารูปแบบไวยากรณ์การตั้งค่า ตัวอย่าง และรายละเอียดฟังก์ชันเชิงลึก

---

## ขอขอบคุณเป็นพิเศษ

ขอแสดงความขอบคุณต่อ [@베스트견과류](https://github.com/bestnuts) ผู้มอบโค้ดสำหรับการสลับด้านซ้าย-ขวามาให้ครับ

## ไลเซนส์

โค้ดนี้อยู่ภายใต้ [MIT License](./LICENSE)

โปรเจกต์นี้ได้รับแรงบันดาลใจดั้งเดิมมาจาก [Text-Effects-by-Akis](https://github.com/YeahAkis/Text-Effects-by-Akis) โดย Shader ทั้งหมดถูกเขียนขึ้นมาใหม่ทั้งหมด
