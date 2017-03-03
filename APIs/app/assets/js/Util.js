var Utils = {
    getParameterByName: function (name) {
        name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
        var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
        return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
    },

    getUrlPattern: function () {
        return '^((https?|ftp)://)([A-Za-z]+\\.)?[A-Za-z0-9-]+(\\.[a-zA-Z0-9\/]{1,4000}){1,2000}(/.*\\?.*)?$';
    },

    getEmailPattern: function () {
        return /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i;
    },
    getEmailMailinatorPattern: function () {
        return /^[0-9a-zA-Z]+([0-9a-zA-Z]*[._+])*[0-9a-zA-Z]+@mailinator.com$/;
    },
    getNumberPattern: function () {
        return /^\d+$/;
    },
    getPositiveNumberPattern: function () {
        return /^([0-9]*[1-9][0-9]*(\.[0-9]+)?|[0]+\.[0-9]*[1-9][0-9]*)$/;
    },

    formatDate: function (date) {
        var mm = moment(date);
        if (mm.isValid()) return mm.format('MM/DD/YYYY');
        return '';
    },

    getUrlVars: function () {
        var vars = [], hash;
        var hashes = window.location.href.toLowerCase().slice(window.location.href.toLowerCase().indexOf('?') + 1).split('&');
        for (var i = 0; i < hashes.length; i++) {
            hash = hashes[i].split('=');
            vars.push(hash[0]);
            vars[hash[0]] = hash[1];
        }
        return vars;
    },

    getOriginVars: function () {
        var vars = [], hash;
        var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
        for (var i = 0; i < hashes.length; i++) {
            hash = hashes[i].split('=');
            vars.push(hash[0]);
            vars[hash[0]] = hash[1];
        }
        return vars;
    }
}

/*----- mixin and helper-----*/

function copyField(source, target, listFields) {
    _.each(listFields, function(f) {
        target[f] = source[f];
    });
}

_.mixin({ 'copyField': copyField });