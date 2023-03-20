package com.danim.service;

import com.danim.dto.InsertPostReq;
import com.danim.dto.InsertPostRes;

public interface MultiPartService {
    InsertPostRes insertPost(InsertPostReq insertPostReq) throws Exception;
}
