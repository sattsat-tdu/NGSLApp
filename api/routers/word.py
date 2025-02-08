from typing import List, Optional

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession

import api.cruds.word as word_crud
from api.db import get_db

import api.schemas.word as word_schema

router = APIRouter()


@router.get("/words", response_model=word_schema.WordsResponse)
async def get_words(
    pos: Optional[str] = None,
    count: Optional[int] = 20,
    start: Optional[int] = 0,
    db: AsyncSession = Depends(get_db)
):
    request = word_schema.WordsRequest(pos=pos, count=count, start=start)
    return await word_crud.get_words(db, request)