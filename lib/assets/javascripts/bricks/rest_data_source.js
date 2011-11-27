// ==========================================================================
// Project:   SproutCore Bricks
// Copyright: ©2011 Paul Chavard
// Author :   Paul Chavard
//
// rest_data_source.js
// ==========================================================================
SB = this.SB || {};

SB.RestDataSource = SC.DataSource.extend({

  resourceURL: function(recordType, store, storeKey) {
    var id, resourceName = recordType.resourceName;
    if (!resourceName) {
      throw SC.Error.create("You have to define resourceName on %@ ...".fmt(recordType));
    }
    if (storeKey) {
      id = store.idFor(storeKey); 
    }
    if (id) {
      return '/%@/%@'.fmt(resourceName, id);
    }
    return '/%@'.fmt(resourceName);
  },

  // fetch

  fetch: function(store, query) {
    var url = this.resourceURL(query.get('recordType'), store);
    this._request({
      url: url,
      action: 'fetchDidComplete'
    }, store, query);
    return true;
  },

  fetchDidComplete: function(response, store, query) {
    if (!response.isError) {
      store.loadRecords(query.get('recordType'), response.data);
      store.dataSourceDidFetchQuery(query);
    } else {
      store.dataSourceDidErrorQuery(query, response);
    }
  },

  // retrieve

  retrieveRecord: function(store, storeKey, id) {
    var url = this.resourceURL(query.get('recordType'), store, storeKey);
    this._request({
      url: url,
      action: 'retrieveDidComplete'
    }, store);
    return true;
  },

  retrieveDidComplete: function(response, store, storeKey) {
    if (!response.isError) {
      var data = response.data;
      store.dataSourceDidComplete(storeKey, data);
    } else {
      this._parseError(response);
      store.dataSourceDidError(storeKey, response);
    }
  },

  // create / update

  createRecord: function(store, storeKey) {
    return this._createOrUpdateRecord(store, storeKey);
  },

  updateRecord: function(store, storeKey) {
    return this._createOrUpdateRecord(store, storeKey, true);
  },

  _createOrUpdateRecord: function(store, storeKey, update) {
    var url = this.resourceURL(store.recordTypeFor(storeKey), store, storeKey);
    this._request({
      url: url,
      method: (update ? 'PUT' : 'POST'),
      action: 'writeDidComplete',
      data: store.readDataHash(storeKey)
    }, store, storeKey);
    return true;
  },

  writeDidComplete: function(response, store, storeKey) {
    if (!response.isError) {
      var data = response.data;
      if (store.idFor(storeKey)) {
        store.dataSourceDidComplete(storeKey, data);
      } else {
        store.dataSourceDidComplete(storeKey, data, data.id);
      }
    } else {
      store.dataSourceDidError(storeKey, response);
    }
  },

  // destroy

  destroyRecord: function(store, storeKey) {
    var url = this.resourceURL(store.recordTypeFor(storeKey), store, storeKey);
    this._request({
      url: url,
      method: 'DELETE',
      action: 'destroyRecordsDidComplete'
    }, store, storeKey);
    return true;
  },

  destroyRecordsDidComplete: function(response, store, storeKey) {
    if (SC.ok(response)) {
      store.dataSourceDidDestroy(storeKey);
    } else {
      this._parseError(response);
      store.dataSourceDidError(storeKey, response);
    }
  },

  _request: function() {
    var args = SC.$.makeArray(arguments),
        options = args.shift(),
        action = (typeof options.action === 'string') ? this[options.action] : options.action;
    SC.$.ajax({
      url: options.url,
      type: options.method || 'GET',
      dataType: 'json',
      data: options.data,
      context: this,
      success: function(data, textStatus, jqXHR) {
        action.apply(this, [{
          data: data,
          status: jqXHR.status
        }].concat(args));
      },
      error: function(jqXHR, textStatus, errorThrown) {
        var data = {};
        try { data = SC.$.parseJSON(jqXHR.responseText); } catch (e) {}
        action.apply(this, [{
          isError: true,
          status: jqXHR.status,
          data: data,
          error: errorThrown
        }].concat(args));
      }
    });
  }
});

