package com.dailycodework.lakesidehotel.service;

import java.io.IOException;
import java.sql.SQLException;

import com.dailycodework.lakesidehotel.model.Aminiti;

public interface IAminitiService {
    Aminiti saveAminiti(Aminiti aminitiRequest) throws SQLException, IOException;
}
