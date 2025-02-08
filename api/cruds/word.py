from sqlalchemy.ext.asyncio import AsyncSession

import api.models.word as word_model
import api.schemas.word as word_schema
from sqlalchemy import select, func





async def get_words(
        db: AsyncSession, request: word_schema.WordsRequest
        ) -> word_schema.WordsResponse:
    
    # ① `COUNT(*)` で該当する単語の総数を取得
    total_query = select(func.count()).select_from(word_model.Word)
    if request.pos:
        total_query = total_query.filter(word_model.Word.pos == request.pos)
    total_result = await db.execute(total_query)
    results_available = total_result.scalar_one()

        # ② 実際の単語リストを取得
    word_query = select(word_model.Word).offset(request.start).limit(request.count)
    if request.pos:
        word_query = word_query.filter(word_model.Word.pos == request.pos)

    result = await db.execute(word_query)
    words = result.scalars().all()
    
    return word_schema.WordsResponse(
        results_available=results_available,
        results_start = request.start,
        words=[word_schema.WordResponse.from_orm(word) for word in words] 
    )
