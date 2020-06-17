package edu.ucla.library.libservices.hathi.generators;

import edu.ucla.library.libservices.hathi.beans.HathiData;

import edu.ucla.library.libservices.hathi.db.mapper.HathiDataMapper;
import edu.ucla.library.libservices.hathi.db.source.DataSourceFactory;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;

@XmlRootElement(name = "hathiItems")
public class HathiDataGenerator
{
  private static final String ITEMS_QUERY = "SELECT * FROM vger_report.hathi_overlap WHERE bib_id IN (:ids)";

  private DataSource ds;
  private String dbName;
  private String bibIDs;
  @XmlElement(name = "items")
  private List<HathiData> items;

  public HathiDataGenerator()
  {
    super();
  }

  public void setDbName(String dbName)
  {
    this.dbName = dbName;
  }

  private String getDbName()
  {
    return dbName;
  }

  private DataSource getDs()
  {
    return ds;
  }

  public void setBibIDs(String bibIDs)
  {
    this.bibIDs = bibIDs;
  }

  private String getBibIDs()
  {
    return bibIDs;
  }

  private void makeConnection()
  {
    ds = DataSourceFactory.createDataSource(getDbName());
  }

  private void makeTestConnection()
  {
    ds = DataSourceFactory.createTestSource();
  }

  @SuppressWarnings("unchecked")
  public void prepItems()
  {
    MapSqlParameterSource parameters;

    makeConnection();


    parameters = new MapSqlParameterSource();
    parameters.addValue("ids", convertIDs());

    items = new NamedParameterJdbcTemplate(getDs()).query(ITEMS_QUERY, parameters, new HathiDataMapper());
  }

  @SuppressWarnings("unchecked")
  public List<HathiData> getItems()
  {
    MapSqlParameterSource parameters;

    makeTestConnection();

    parameters = new MapSqlParameterSource();
    parameters.addValue("ids", convertIDs());

    items = new NamedParameterJdbcTemplate(getDs()).query(ITEMS_QUERY, parameters, new HathiDataMapper());

    return items;
  }

  private List<Integer> convertIDs()
  {
    List<Integer> converted;

    converted = new ArrayList<Integer>();
    for (String id: getBibIDs().split(","))
      converted.add(Integer.parseInt(id));

    return converted;
  }
}
