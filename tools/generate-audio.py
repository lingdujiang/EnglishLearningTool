#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
批量生成 50 个英语单词的 MP3 发音文件
使用 gTTS (Google Text-to-Speech) - 免费，无需 API key

安装依赖:
pip install gTTS

使用方法:
python generate-audio.py
"""

import os
from gtts import gTTS

# 50 个一年级英语单词
words = [
    # 动物类
    'cat', 'dog', 'bird', 'fish', 'rabbit',
    'duck', 'pig', 'cow', 'horse', 'sheep',
    # 颜色类
    'red', 'blue', 'green', 'yellow', 'orange',
    'purple', 'pink', 'black', 'white', 'brown',
    # 数字类
    'one', 'two', 'three', 'four', 'five',
    'six', 'seven', 'eight', 'nine', 'ten',
    # 家庭成员
    'mom', 'dad', 'grandma', 'grandpa', 'sister',
    'brother', 'baby', 'family', 'uncle', 'aunt',
    # 日常物品
    'ball', 'book', 'pencil', 'bag', 'cup',
    'chair', 'table', 'bed', 'door', 'window'
]

# 创建 audio 文件夹
audio_dir = 'audio'
if not os.path.exists(audio_dir):
    os.makedirs(audio_dir)
    print(f'✅ 创建文件夹：{audio_dir}/')

print(f'🎤 开始生成 {len(words)} 个单词的发音文件...\n')

success_count = 0
fail_count = 0

for i, word in enumerate(words, 1):
    try:
        filename = f'{audio_dir}/{word}.mp3'
        print(f'[{i}/{len(words)}] 生成：{word}.mp3', end=' ')
        
        # 使用 Google TTS (英语)
        tts = gTTS(text=word, lang='en', tld='com')
        tts.save(filename)
        
        # 验证文件是否生成成功
        if os.path.exists(filename) and os.path.getsize(filename) > 0:
            print('✅')
            success_count += 1
        else:
            print('❌ 文件为空')
            fail_count += 1
            
    except Exception as e:
        print(f'❌ 失败：{e}')
        fail_count += 1

print(f'\n{"="*50}')
print(f'✅ 成功：{success_count}/{len(words)}')
print(f'❌ 失败：{fail_count}/{len(words)}')

if success_count == len(words):
    print('\n🎉 所有单词发音文件生成成功！')
    print(f'📂 文件位置：{os.path.abspath(audio_dir)}/')
else:
    print('\n⚠ 部分文件生成失败，请检查网络连接')
    print('💡 可以手动下载失败的单词，或重试')

print('\n下一步:')
print('1. 打开 index.html')
print('2. 点击"听发音"按钮')
print('3. 应该能听到清晰的发音了！')
