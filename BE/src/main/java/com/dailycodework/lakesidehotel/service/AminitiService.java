package com.dailycodework.lakesidehotel.service;

import java.io.IOException;
import java.sql.SQLException;

import org.springframework.stereotype.Service;

import com.dailycodework.lakesidehotel.model.Aminiti;
import com.dailycodework.lakesidehotel.repository.AminitiRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AminitiService implements IAminitiService {

    private final AminitiRepository aminitiRepository;

    @Override
    public Aminiti saveAminiti(Aminiti aminitiRequest) throws SQLException, IOException {

        return aminitiRepository.save(aminitiRequest);
    }

}
