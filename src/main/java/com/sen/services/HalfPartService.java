package com.sen.services;

import com.sen.beans.HalfPart;
import com.sen.beans.Paper;

import java.util.List;

public interface HalfPartService {

    void saveHalfPart(HalfPart halfPart);
    void deleteBatchHP(List<String> ids);
    void deleteHalfPart(String id);

    boolean checkProgressHas(String sno);

    HalfPart getProgressBySno(String sno);

    List<HalfPart> getAllHalfParts();

    HalfPart getHalfPart(String sno);

    List<HalfPart> getHalfPartBy(HalfPart halfPart);
}
