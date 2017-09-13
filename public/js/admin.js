'use strict';

$(document).ready(function() {
  // get stats
  $.get('./api/statistics', function(stats, status) {
    for (let measure in stats)
      $('#count-' + measure).html(stats[measure]);
  });

  // fill user table
  $.get('./api/users', function(users, status) {
    if (status !== 'success') return showAlert(users, 'error');
    // convert user objects to arrays for further use with DataTables
    users.forEach(function(user, i, arr) {
      users[i] = $.map(user, function(e) { return e || ''; });
    });

    $('#user-table').dataTable({
      data: users,
    });
  });

  // fill newsletter table
  $.get('./api/newsletter', function(users, status) {
    if (status !== 'success') return showAlert(users, 'error');
    // convert user objects to arrays for further use with DataTables
    users.forEach(function(user, i, arr) {
      users[i] = $.map(user, function(e) { return e || ''; });
    });

    $('#newsletter-table').dataTable({
      data: users,
    });
  });
});
