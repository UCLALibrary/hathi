package edu.ucla.library.libservices.hathi.beans;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;

@XmlType
@XmlAccessorType(XmlAccessType.FIELD)
public class HathiData
{
  @XmlElement(name = "oclcNumber")
  private String oclcNumber;
  @XmlElement(name = "bibID")
  private int bibID;
  @XmlElement(name = "itemType")
  private String itemType;
  @XmlElement(name = "accessLevel")
  private String accessLevel;
  @XmlElement(name = "rightsCode")
  private String rightsCode;
  @XmlElement(name = "hathiBibKey")
  private String hathiBibKey;

  public HathiData()
  {
    super();
  }

  public void setOclcNumber(String oclcNumber)
  {
    this.oclcNumber = oclcNumber;
  }

  public String getOclcNumber()
  {
    return oclcNumber;
  }

  public void setBibID(int bibID)
  {
    this.bibID = bibID;
  }

  public int getBibID()
  {
    return bibID;
  }

  public void setItemType(String itemType)
  {
    this.itemType = itemType;
  }

  public String getItemType()
  {
    return itemType;
  }

  public void setAccessLevel(String accessLevel)
  {
    this.accessLevel = accessLevel;
  }

  public String getAccessLevel()
  {
    return accessLevel;
  }

  public void setRightsCode(String rightsCode)
  {
    this.rightsCode = rightsCode;
  }

  public String getRightsCode()
  {
    return rightsCode;
  }

  public void setHathiBibKey(String hathiBibKey)
  {
    this.hathiBibKey = hathiBibKey;
  }

  public String getHathiBibKey()
  {
    return hathiBibKey;
  }

  @Override
  public String toString()
  {
    return getBibID() + " : " + getOclcNumber() + " : " + getItemType() + " : " + getAccessLevel() + " : " +
           getRightsCode() + " : " + getHathiBibKey();
  }
}
