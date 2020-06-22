package edu.ucla.library.libservices.hathi.db.mapper;

import edu.ucla.library.libservices.hathi.beans.HathiData;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class HathiDataMapper
  implements RowMapper
{
  public HathiDataMapper()
  {
    super();
  }

  @Override
  public Object mapRow(ResultSet rs, int i)
    throws SQLException
  {
    HathiData bean;

    bean = new HathiData();
    bean.setAccessLevel(rs.getString("access_lvl"));
    bean.setBibID(rs.getInt("bib_id"));
    bean.setHathiBibKey(rs.getString("hathi_bib_key"));
    bean.setItemType(rs.getString("item_type"));
    bean.setOclcNumber(rs.getString("oclc_number"));
    bean.setRightsCode(rs.getString("rights_code"));

    return bean;
  }
}
