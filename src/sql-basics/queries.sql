SELECT cb.iso_3, cc.iso_3, tsn.obs_date, tsn.value
FROM time_series_num tsn
    JOIN series s on tsn.series_id = s.id
    JOIN currency cb on s.base_currency_id = cb.id
    JOIN currency cc on s.counter_currency_id = cc.id
WHERE cb.iso_3 = 'eur'
;