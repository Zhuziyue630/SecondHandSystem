package com.secondhand.entity;

import java.util.Date;

public class Item {
    private Integer id;
    private Integer userId;
    private String title;
    private String description;
    private Integer itemType;
    private String location;
    private Date foundLostDate;
    private String imageUrl;
    private Integer status;
    private Date createTime;
    private Date updateTime;
    private String username;

    // 构造方法
    public Item() {}

    public Item(Integer userId, String title, String description, Integer itemType,
                String location, Date foundLostDate) {
        this.userId = userId;
        this.title = title;
        this.description = description;
        this.itemType = itemType;
        this.location = location;
        this.foundLostDate = foundLostDate;
    }

    // Getter和Setter
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Integer getItemType() { return itemType; }
    public void setItemType(Integer itemType) { this.itemType = itemType; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public Date getFoundLostDate() { return foundLostDate; }
    public void setFoundLostDate(Date foundLostDate) { this.foundLostDate = foundLostDate; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }

    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }

    public Date getUpdateTime() { return updateTime; }
    public void setUpdateTime(Date updateTime) { this.updateTime = updateTime; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
}