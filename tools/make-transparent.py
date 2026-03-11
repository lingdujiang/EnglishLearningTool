from PIL import Image
import os

# 图片目录
input_dir = r"D:\clawProject\EnglishLearningProject\code\images"

# 处理 9 张图片
for i in range(9):
    filename = f"egg_{i}.png"
    input_path = os.path.join(input_dir, filename)
    
    try:
        # 打开图片
        img = Image.open(input_path)
        
        # 转换为 RGBA 模式
        img = img.convert("RGBA")
        
        # 获取宽高
        width, height = img.size
        
        # 创建新的图片数据
        datas = img.load()
        
        # 遍历所有像素
        for y in range(height):
            for x in range(width):
                r, g, b, a = datas[x, y]
                
                # 更精确的白色检测：RGB 都大于 220 且差异小于 20
                if r > 220 and g > 220 and b > 220 and abs(r-g) < 20 and abs(g-b) < 20 and abs(r-b) < 20:
                    datas[x, y] = (255, 255, 255, 0)  # 完全透明
                # 处理接近白色的浅灰色
                elif r > 200 and g > 200 and b > 200 and abs(r-g) < 30 and abs(g-b) < 30 and abs(r-b) < 30:
                    # 半透明过渡
                    alpha = int((255 - max(r, g, b)) * 3)
                    datas[x, y] = (r, g, b, min(alpha, 128))
        
        # 保存图片
        img.save(input_path, "PNG")
        
        print(f"[OK] Done: {filename}")
        
    except Exception as e:
        print(f"[ERROR] Failed {filename}: {e}")

print("\n[SUCCESS] All images processed!")
