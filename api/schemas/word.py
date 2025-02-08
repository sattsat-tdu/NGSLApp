from pydantic import BaseModel
from typing import List, Optional

class WordsRequest(BaseModel):
    pos: Optional[str] = None  # 品詞（指定なしなら全て）
    count: Optional[int] = 20  # 取得する単語の数（デフォルト20）
    start: Optional[int] = 0   # ページング用の開始位置（デフォルト0）

class WordResponse(BaseModel):
    id: int
    english: str
    japanese: str
    pos: str
    en_sentence: str
    jp_sentence: str

    class Config:
        from_attributes = True

class WordsResponse(BaseModel):
    results_available: int
    results_start: int
    words: List[WordResponse]
