module StaticPagesHelper

  def truncate_table

    sql_query = "truncate table c3demand.temp_josh"
    ActiveRecord::Base.connection.execute(sql_query)

  end

end
