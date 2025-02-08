from sqlalchemy import create_engine
import os
from api.models.word import Base


TEST_DATABASE_URL = os.getenv("TEST_DATABASE_URL")

if DATABASE_URL is None:
    raise RuntimeError("環境変数 'TEST_DATABASE_URL' が設定されていません。")

engine = create_engine(TEST_DATABASE_URL, echo=True)


def reset_database():
    Base.metadata.drop_all(bind=engine)
    Base.metadata.create_all(bind=engine)


if __name__ == "__main__":
    reset_database()