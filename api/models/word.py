from sqlalchemy import Column, Integer, String, ForeignKey
# from sqlalchemy.orm import relationship

from api.db import Base


class Word(Base):
    __tablename__ = "words"

    id = Column(Integer, primary_key=True)
    english = Column(String(255))
    japanese = Column(String(255))
    pos = Column(String(50))
    en_sentence = Column(String(1024))
    jp_sentence = Column(String(1024))