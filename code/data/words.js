// 一年级英语单词库 - 50 词
// 分类：动物 (10) + 颜色 (10) + 数字 (10) + 家庭成员 (10) + 日常物品 (10)

const wordBank = [
  // ========== 动物类 (1-10) ==========
  {
    id: 1,
    word: "cat",
    meaning: "猫",
    image: "images/cat.png",
    audio: "audio/cat.mp3",
    sentence: "This is a cat."
  },
  {
    id: 2,
    word: "dog",
    meaning: "狗",
    image: "images/dog.png",
    audio: "audio/dog.mp3",
    sentence: "This is a dog."
  },
  {
    id: 3,
    word: "bird",
    meaning: "鸟",
    image: "images/bird.png",
    audio: "audio/bird.mp3",
    sentence: "The bird can fly."
  },
  {
    id: 4,
    word: "fish",
    meaning: "鱼",
    image: "images/fish.png",
    audio: "audio/fish.mp3",
    sentence: "The fish swims."
  },
  {
    id: 5,
    word: "rabbit",
    meaning: "兔子",
    image: "images/rabbit.png",
    audio: "audio/rabbit.mp3",
    sentence: "The rabbit is cute."
  },
  {
    id: 6,
    word: "duck",
    meaning: "鸭子",
    image: "images/duck.png",
    audio: "audio/duck.mp3",
    sentence: "The duck says quack."
  },
  {
    id: 7,
    word: "pig",
    meaning: "猪",
    image: "images/pig.png",
    audio: "audio/pig.mp3",
    sentence: "The pig is pink."
  },
  {
    id: 8,
    word: "cow",
    meaning: "奶牛",
    image: "images/cow.png",
    audio: "audio/cow.mp3",
    sentence: "The cow gives milk."
  },
  {
    id: 9,
    word: "horse",
    meaning: "马",
    image: "images/horse.png",
    audio: "audio/horse.mp3",
    sentence: "The horse runs fast."
  },
  {
    id: 10,
    word: "sheep",
    meaning: "绵羊",
    image: "images/sheep.png",
    audio: "audio/sheep.mp3",
    sentence: "The sheep says baa."
  },
  
  // ========== 颜色类 (11-20) ==========
  {
    id: 11,
    word: "red",
    meaning: "红色",
    image: "images/red.png",
    audio: "audio/red.mp3",
    sentence: "The apple is red."
  },
  {
    id: 12,
    word: "blue",
    meaning: "蓝色",
    image: "images/blue.png",
    audio: "audio/blue.mp3",
    sentence: "The sky is blue."
  },
  {
    id: 13,
    word: "green",
    meaning: "绿色",
    image: "images/green.png",
    audio: "audio/green.mp3",
    sentence: "The grass is green."
  },
  {
    id: 14,
    word: "yellow",
    meaning: "黄色",
    image: "images/yellow.png",
    audio: "audio/yellow.mp3",
    sentence: "The banana is yellow."
  },
  {
    id: 15,
    word: "orange",
    meaning: "橙色",
    image: "images/orange.png",
    audio: "audio/orange.mp3",
    sentence: "The orange is orange."
  },
  {
    id: 16,
    word: "purple",
    meaning: "紫色",
    image: "images/purple.png",
    audio: "audio/purple.mp3",
    sentence: "The grape is purple."
  },
  {
    id: 17,
    word: "pink",
    meaning: "粉色",
    image: "images/pink.png",
    audio: "audio/pink.mp3",
    sentence: "The flower is pink."
  },
  {
    id: 18,
    word: "black",
    meaning: "黑色",
    image: "images/black.png",
    audio: "audio/black.mp3",
    sentence: "The cat is black."
  },
  {
    id: 19,
    word: "white",
    meaning: "白色",
    image: "images/white.png",
    audio: "audio/white.mp3",
    sentence: "The snow is white."
  },
  {
    id: 20,
    word: "brown",
    meaning: "棕色",
    image: "images/brown.png",
    audio: "audio/brown.mp3",
    sentence: "The bear is brown."
  },
  
  // ========== 数字类 (21-30) ==========
  {
    id: 21,
    word: "one",
    meaning: "一",
    image: "images/one.png",
    audio: "audio/one.mp3",
    sentence: "I have one nose."
  },
  {
    id: 22,
    word: "two",
    meaning: "二",
    image: "images/two.png",
    audio: "audio/two.mp3",
    sentence: "I have two eyes."
  },
  {
    id: 23,
    word: "three",
    meaning: "三",
    image: "images/three.png",
    audio: "audio/three.mp3",
    sentence: "I have three toys."
  },
  {
    id: 24,
    word: "four",
    meaning: "四",
    image: "images/four.png",
    audio: "audio/four.mp3",
    sentence: "A dog has four legs."
  },
  {
    id: 25,
    word: "five",
    meaning: "五",
    image: "images/five.png",
    audio: "audio/five.mp3",
    sentence: "I have five fingers."
  },
  {
    id: 26,
    word: "six",
    meaning: "六",
    image: "images/six.png",
    audio: "audio/six.mp3",
    sentence: "I see six birds."
  },
  {
    id: 27,
    word: "seven",
    meaning: "七",
    image: "images/seven.png",
    audio: "audio/seven.mp3",
    sentence: "There are seven days."
  },
  {
    id: 28,
    word: "eight",
    meaning: "八",
    image: "images/eight.png",
    audio: "audio/eight.mp3",
    sentence: "I have eight crayons."
  },
  {
    id: 29,
    word: "nine",
    meaning: "九",
    image: "images/nine.png",
    audio: "audio/nine.mp3",
    sentence: "I count to nine."
  },
  {
    id: 30,
    word: "ten",
    meaning: "十",
    image: "images/ten.png",
    audio: "audio/ten.mp3",
    sentence: "I have ten toes."
  },
  
  // ========== 家庭成员类 (31-40) ==========
  {
    id: 31,
    word: "mom",
    meaning: "妈妈",
    image: "images/mom.png",
    audio: "audio/mom.mp3",
    sentence: "I love my mom."
  },
  {
    id: 32,
    word: "dad",
    meaning: "爸爸",
    image: "images/dad.png",
    audio: "audio/dad.mp3",
    sentence: "I love my dad."
  },
  {
    id: 33,
    word: "grandma",
    meaning: "奶奶/外婆",
    image: "images/grandma.png",
    audio: "audio/grandma.mp3",
    sentence: "Grandma tells stories."
  },
  {
    id: 34,
    word: "grandpa",
    meaning: "爷爷/外公",
    image: "images/grandpa.png",
    audio: "audio/grandpa.mp3",
    sentence: "Grandpa is kind."
  },
  {
    id: 35,
    word: "sister",
    meaning: "姐姐/妹妹",
    image: "images/sister.png",
    audio: "audio/sister.mp3",
    sentence: "My sister is nice."
  },
  {
    id: 36,
    word: "brother",
    meaning: "哥哥/弟弟",
    image: "images/brother.png",
    audio: "audio/brother.mp3",
    sentence: "My brother plays with me."
  },
  {
    id: 37,
    word: "baby",
    meaning: "宝宝",
    image: "images/baby.png",
    audio: "audio/baby.mp3",
    sentence: "The baby is small."
  },
  {
    id: 38,
    word: "family",
    meaning: "家庭",
    image: "images/family.png",
    audio: "audio/family.mp3",
    sentence: "I love my family."
  },
  {
    id: 39,
    word: "uncle",
    meaning: "叔叔/舅舅",
    image: "images/uncle.png",
    audio: "audio/uncle.mp3",
    sentence: "My uncle visits us."
  },
  {
    id: 40,
    word: "aunt",
    meaning: "阿姨/姑姑",
    image: "images/aunt.png",
    audio: "audio/aunt.mp3",
    sentence: "My aunt is friendly."
  },
  
  // ========== 日常物品类 (41-50) ==========
  {
    id: 41,
    word: "ball",
    meaning: "球",
    image: "images/ball.png",
    audio: "audio/ball.mp3",
    sentence: "I play with a ball."
  },
  {
    id: 42,
    word: "book",
    meaning: "书",
    image: "images/book.png",
    audio: "audio/book.mp3",
    sentence: "I read a book."
  },
  {
    id: 43,
    word: "pencil",
    meaning: "铅笔",
    image: "images/pencil.png",
    audio: "audio/pencil.mp3",
    sentence: "I write with a pencil."
  },
  {
    id: 44,
    word: "bag",
    meaning: "书包",
    image: "images/bag.png",
    audio: "audio/bag.mp3",
    sentence: "My bag is blue."
  },
  {
    id: 45,
    word: "cup",
    meaning: "杯子",
    image: "images/cup.png",
    audio: "audio/cup.mp3",
    sentence: "I drink from a cup."
  },
  {
    id: 46,
    word: "chair",
    meaning: "椅子",
    image: "images/chair.png",
    audio: "audio/chair.mp3",
    sentence: "I sit on a chair."
  },
  {
    id: 47,
    word: "table",
    meaning: "桌子",
    image: "images/table.png",
    audio: "audio/table.mp3",
    sentence: "The book is on the table."
  },
  {
    id: 48,
    word: "bed",
    meaning: "床",
    image: "images/bed.png",
    audio: "audio/bed.mp3",
    sentence: "I sleep in my bed."
  },
  {
    id: 49,
    word: "door",
    meaning: "门",
    image: "images/door.png",
    audio: "audio/door.mp3",
    sentence: "Open the door."
  },
  {
    id: 50,
    word: "window",
    meaning: "窗户",
    image: "images/window.png",
    audio: "audio/window.mp3",
    sentence: "Look out the window."
  }
];
