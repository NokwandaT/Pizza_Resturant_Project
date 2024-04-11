


SET XACT_ABORT ON

BEGIN TRANSACTION QUICKDBD

CREATE TABLE [Orders] (
    [Row_id] int  NOT NULL ,
    [order_id] varchar(10)  NOT NULL ,
    [created_at] datetime  NOT NULL ,
    [item_id] varchar(10)  NOT NULL ,
    [quatity] int  NOT NULL ,
    [cust_id] int  NOT NULL ,
    [delivery] varchar(10)  NOT NULL ,
    [add_id] int  NOT NULL ,
    CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED (
        [Row_id] ASC
    )
)

CREATE TABLE [Customer] (
    [cust_id] int  NOT NULL ,
    [cust_fistname] varchar(50)  NOT NULL ,
    [cust_lastname] varchar(50)  NOT NULL ,
    CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED (
        [cust_id] ASC
    )
)

CREATE TABLE [address] (
    [add_id] int  NOT NULL ,
    [delivery_address1] varchar(200)  NOT NULL ,
    [delivery_address2] varchar(200)  NULL ,
    [deliver_city] varchar(50)  NOT NULL ,
    [deivery_zipcode] varchar(20)  NOT NULL ,
    CONSTRAINT [PK_address] PRIMARY KEY CLUSTERED (
        [add_id] ASC
    )
)

CREATE TABLE [item] (
    [item_id] varchar(10)  NOT NULL ,
    [sku] varchar(20)  NOT NULL ,
    [item_name] varchar(50)  NOT NULL ,
    [item_cat] varchar(50)  NOT NULL ,
    [item_size] varchar(20)  NOT NULL ,
    [iem_price] decimal(5,2)  NOT NULL ,
    CONSTRAINT [PK_item] PRIMARY KEY CLUSTERED (
        [item_id] ASC
    )
)

CREATE TABLE [ingredients] (
    [ing_id] varchar(10)  NOT NULL ,
    [ing_name] varchar(200)  NOT NULL ,
    [ing_weight] int  NOT NULL ,
    [ing_price] decimal(5,2)  NOT NULL ,
    [ing_meas] varchar(20)  NOT NULL ,
    CONSTRAINT [PK_ingredients] PRIMARY KEY CLUSTERED (
        [ing_id] ASC
    )
)

CREATE TABLE [recipe] (
    [row_id] int  NOT NULL ,
    [recipe_id] varchar(20)  NOT NULL ,
    [ing_id] varchar(10)  NOT NULL ,
    [quantity] int  NOT NULL ,
    CONSTRAINT [PK_recipe] PRIMARY KEY CLUSTERED (
        [row_id] ASC
    )
)

CREATE TABLE [inventory] (
    [inv_id] int  NOT NULL ,
    [item_id] varchar(10)  NOT NULL ,
    [quality] int  NOT NULL ,
    CONSTRAINT [PK_inventory] PRIMARY KEY CLUSTERED (
        [inv_id] ASC
    )
)

CREATE TABLE [staff] (
    [staff_id] varchar(20)  NOT NULL ,
    [first_name] varchar(50)  NOT NULL ,
    [last_name] varchar(50)  NOT NULL ,
    [position] varchar(100)  NOT NULL ,
    [hourly_rate] decimal(5,2)  NOT NULL ,
    CONSTRAINT [PK_staff] PRIMARY KEY CLUSTERED (
        [staff_id] ASC
    )
)

CREATE TABLE [rota] (
    [row_id] int  NOT NULL ,
    [rota_id] varchar(20)  NOT NULL ,
    [date] datetime  NOT NULL ,
    [shift_id] varchar(20)  NOT NULL ,
    [staff_id] varchar(20)  NOT NULL ,
    CONSTRAINT [PK_rota] PRIMARY KEY CLUSTERED (
        [row_id] ASC
    )
)

CREATE TABLE [shift] (
    [shift_id] varchar(20)  NOT NULL ,
    [day_of_work] varchar(10)  NOT NULL ,
    [start_time] time  NOT NULL ,
    [end_time] time  NOT NULL 
)

ALTER TABLE [Orders] WITH CHECK ADD CONSTRAINT [FK_Orders_cust_id] FOREIGN KEY([cust_id])
REFERENCES [Customer] ([cust_id])

ALTER TABLE [Orders] CHECK CONSTRAINT [FK_Orders_cust_id]

CREATE UNIQUE INDEX [IX_Orders]
ON [Orders]  ([add_id])


ALTER TABLE [address] WITH CHECK ADD CONSTRAINT [FK_address_add_id] FOREIGN KEY([add_id])
REFERENCES [Orders] ([add_id])

ALTER TABLE [address] CHECK CONSTRAINT [FK_address_add_id]

CREATE UNIQUE INDEX [IT_Orders]
ON [Orders]  ([item_id])


ALTER TABLE [item] WITH CHECK ADD CONSTRAINT [FK_item_item_id] FOREIGN KEY([item_id])
REFERENCES [Orders] ([item_id])

ALTER TABLE [item] CHECK CONSTRAINT [FK_item_item_id]

CREATE UNIQUE INDEX [IX_recipe]
ON [recipe]  ([recipe_id])


ALTER TABLE [item] WITH CHECK ADD CONSTRAINT [FK_item_sku] FOREIGN KEY([sku])
REFERENCES [recipe] ([recipe_id])

ALTER TABLE [item] CHECK CONSTRAINT [FK_item_sku]

CREATE UNIQUE INDEX [IR_recipe]
ON [recipe]  ([ing_id])

ALTER TABLE [ingredients] WITH CHECK ADD CONSTRAINT [FK_ingredients_ing_id] FOREIGN KEY([ing_id])
REFERENCES [recipe] ([ing_id])

ALTER TABLE [ingredients] CHECK CONSTRAINT [FK_ingredients_ing_id]

CREATE UNIQUE INDEX [IX_inventory]
ON [inventory]  ([item_id])

ALTER TABLE [recipe] WITH CHECK ADD CONSTRAINT [FK_recipe_ing_id] FOREIGN KEY([ing_id])
REFERENCES [inventory] ([item_id])

ALTER TABLE [recipe] CHECK CONSTRAINT [FK_recipe_ing_id]

CREATE UNIQUE INDEX [IC_Orders]
ON [Orders]  ([created_at])

ALTER TABLE [rota] WITH CHECK ADD CONSTRAINT [FK_rota_date] FOREIGN KEY([date])
REFERENCES [Orders] ([created_at])

ALTER TABLE [rota] CHECK CONSTRAINT [FK_rota_date]

CREATE UNIQUE INDEX [IX_shift]
ON [shift]  ([shift_id])

ALTER TABLE [rota] WITH CHECK ADD CONSTRAINT [FK_rota_shift_id] FOREIGN KEY([shift_id])
REFERENCES [shift] ([shift_id])

ALTER TABLE [rota] CHECK CONSTRAINT [FK_rota_shift_id]

ALTER TABLE [rota] WITH CHECK ADD CONSTRAINT [FK_rota_staff_id] FOREIGN KEY([staff_id])
REFERENCES [staff] ([staff_id])

ALTER TABLE [rota] CHECK CONSTRAINT [FK_rota_staff_id]

COMMIT TRANSACTION QUICKDBD