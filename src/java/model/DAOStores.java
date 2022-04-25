package model;

import entity.Stores;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

public class DAOStores extends ConnectDB {

    public int Register(String id, String name, String pass) {
        int n = 0;
        String sql = "select * from stores where username = '" + name + "'";
        ResultSet rs = getData(sql);
        try {
            if (!rs.next()) {
                sql = "update stores set username = ?, password = ? where stor_id = ?";
                PreparedStatement pre = conn.prepareStatement(sql);
                pre.setString(1, name);
                pre.setString(2, pass);
                pre.setString(3, id);
                n = pre.executeUpdate();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }
    
    public Stores login(String username, String password) {
        Stores login = null;
        String sql = "select * from stores where username=? and password=?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, username);
            pre.setString(2, password);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                login = new Stores(username, password);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return login;
    }

    public int addStores(Stores store) {
        int n = 0;
        String sql = "INSERT INTO [stores]"
                + "           ([stor_id],[stor_name],[stor_address],[city],[state],[zip])"
                + "     VALUES(?,?,?,?,?,?)";

        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, store.getStor_id());
            pre.setString(2, store.getStor_name());
            pre.setString(3, store.getStor_address());
            pre.setString(4, store.getCity());
            pre.setString(5, store.getState());
            pre.setString(6, store.getZip());

            n = pre.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public int updateStore(Stores store) {
        int n = 0;
        String sql
                = "UPDATE [stores]"
                + "   SET [stor_name] =  ?"
                + "      ,[stor_address] =  ?"
                + "      ,[city] =  ?"
                + "      ,[state] =  ?"
                + "      ,[zip] =  ?"
                + " WHERE [stor_id] = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);

            pre.setString(1, store.getStor_name());
            pre.setString(2, store.getStor_address());
            pre.setString(3, store.getCity());
            pre.setString(4, store.getState());
            pre.setString(5, store.getZip());
            pre.setString(6, store.getStor_id());

            n = pre.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return n;
    }

    public void removeStore(String storeID) {

        try {
            String sql
                    = "DELETE FROM [sales]"
                    + "WHERE sales.stor_id = '" + storeID + "'"
                    + "DELETE FROM [stores]"
                    + "WHERE stores.stor_id ='" + storeID + "'";

            Statement state = conn.createStatement();
            state.executeUpdate(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public Vector<Stores> viewAllStores() {
        Vector<Stores> vector = new Vector<Stores>();
        try {
            String sql = "SELECT * FROM stores";
            ResultSet rs = getData(sql);
            while (rs.next()) {
                String stor_id = rs.getString(1);
                String stor_name = rs.getString(2);
                String stor_address = rs.getString(3);
                String city = rs.getString(4);
                String state = rs.getString(5);
                String zip = rs.getString(6);

                Stores obj = new Stores(stor_id, stor_name, stor_address, city, state, zip);
                vector.add(obj);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vector;

    }

}
