package edu.ucla.library.libservices.hathi.db.source;

import javax.naming.InitialContext;
import javax.naming.NamingException;

import javax.sql.DataSource;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import javax.naming.Context;

public class DataSourceFactory
{
  public DataSourceFactory()
  {
    super();
  }

  public static DataSource createDataSource(String name)
  {
    Context envContext;
    InitialContext context;
    DataSource connection;

    try
    {
      context = new InitialContext();
      envContext = (Context) context.lookup("java:/comp/env");
      connection = (DataSource) envContext.lookup(name);
      //context = new InitialContext();
      //connection = ( DataSource ) context.lookup( name );
    }
    catch (NamingException e)
    {
      e.printStackTrace();
      connection = null;
    }

    return connection;
  }

  public static DriverManagerDataSource createTestSource()
  {
    DriverManagerDataSource ds;

    ds = new DriverManagerDataSource();
    ds.setDriverClassName("oracle.jdbc.OracleDriver");
    ds.setUrl("jdbc:oracle:thin:@127.0.0.1:1521:VGER");
    ds.setUsername("ucla_preaddb");
    ds.setPassword("ucla_preaddb");

    return ds;
  }
}
