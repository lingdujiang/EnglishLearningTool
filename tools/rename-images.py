import shutil
import os

# 源目录和目标目录
src_dir = r"C:\Users\jiangqiming\Downloads\eggs"
dst_dir = r"D:\clawProject\EnglishLearningProject\code\images"

# 复制并重命名
# egg_1.png -> egg_0.png
# egg_2.png -> egg_1.png
# egg_3.png -> egg_2.png
# egg_4.png -> egg_3.png
# egg_5.png -> egg_4.png

mapping = {
    'egg_1.png': 'egg_0.png',
    'egg_2.png': 'egg_1.png',
    'egg_3.png': 'egg_2.png',
    'egg_4.png': 'egg_3.png',
    'egg_5.png': 'egg_4.png'
}

for src_name, dst_name in mapping.items():
    src_path = os.path.join(src_dir, src_name)
    dst_path = os.path.join(dst_dir, dst_name)
    
    if os.path.exists(src_path):
        shutil.copy2(src_path, dst_path)
        print(f"[OK] {src_name} -> {dst_name}")
    else:
        print(f"[ERROR] 源文件不存在：{src_path}")

print("\n[SUCCESS] 完成！")
