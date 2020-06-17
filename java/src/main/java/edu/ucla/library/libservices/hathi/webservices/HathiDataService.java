package edu.ucla.library.libservices.hathi.webservices;

import edu.ucla.library.libservices.hathi.generators.HathiDataGenerator;

import javax.servlet.ServletConfig;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;

@Path("/data/")
public class HathiDataService
{
  @Context
  ServletConfig config;

  public HathiDataService()
  {
    super();
  }

  @GET
  @Produces("application/json")
  @Path("forids/{bibIDs}")
  public HathiDataGenerator getData(@PathParam( "bibIDs" )
    String bibIDs)
  {
    HathiDataGenerator docMaker;

    docMaker = new HathiDataGenerator();

    docMaker.setDbName(config.getServletContext().getInitParameter("datasource.vger"));
    docMaker.setBibIDs(bibIDs);
    docMaker.prepItems();

    return docMaker;
  }
}
