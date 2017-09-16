﻿(function () {
    'use strict';

    angular
        .module('Nidan')
        .controller('FixAssetController', FixAssetController);

    FixAssetController.$inject = ['$window', 'FixAssetService', 'Paging', 'OrderService', 'OrderBy', 'Order', '$uibModal'];

    function FixAssetController($window, FixAssetService, Paging, OrderService, OrderBy, Order, $uibModal, $modalInstance) {
        /* jshint validthis:true */
        var vm = this;
        vm.fixAssets = [];
        vm.FixAssetId;
        vm.paging = new Paging;
        vm.pageChanged = pageChanged;
        vm.orderBy = new OrderBy;
        vm.order = order;
        vm.orderClass = orderClass;
        vm.editFixAsset = editFixAsset;
        vm.searchFixAsset = searchFixAsset;
        vm.viewFixAsset = viewFixAsset;
        vm.searchFixAssetByDate = searchFixAssetByDate;
        vm.retrieveCentreFixAssetsByFixAssetId = retrieveCentreFixAssetsByFixAssetId;
        vm.searchKeyword = "";
        vm.searchMessage = "";
        vm.initialise = initialise;

        function initialise() {
            vm.orderBy.property = "DateofPurchase";
            vm.orderBy.direction = "Ascending";
            vm.orderBy.class = "desc";
            order("DateofPurchase");
        }

        function retrieveFixAssets() {
            return FixAssetService.retrieveFixAssets(vm.paging, vm.orderBy)
                .then(function (response) {
                    vm.fixAssets = response.data.Items;
                    vm.paging.totalPages = response.data.TotalPages;
                    vm.paging.totalResults = response.data.TotalResults;
                    return vm.fixAssets;
                });
        }

        function retrieveCentreFixAssetsByFixAssetId(FixAssetId) {
            vm.FixAssetId;
            vm.orderBy.property = "CentreFixAssetId";
            vm.orderBy.direction = "Ascending";
            vm.orderBy.class = "asc";
            return FixAssetService.retrieveCentreFixAssetsByFixAssetId(FixAssetId, vm.paging, vm.orderBy)
            .then(function (response) {
                vm.centreFixAssets = response.data.Items;
                vm.paging.totalPages = response.data.TotalPages;
                vm.paging.totalResults = response.data.TotalResults;
                return vm.centreFixAssets;
            });
        }

        function searchFixAsset(searchKeyword) {
            vm.searchKeyword = searchKeyword;
            return FixAssetService.searchFixAsset(vm.searchKeyword, vm.paging, vm.orderBy)
              .then(function (response) {
                  vm.fixAssets = response.data.Items;
                  vm.paging.totalPages = response.data.TotalPages;
                  vm.paging.totalResults = response.data.TotalResults;
                  vm.searchMessage = vm.fixAssets.length === 0 ? "No Records Found" : "";
                  return vm.fixAssets;
              });
        }

        function searchFixAssetByDate(fromDate, toDate) {
            vm.fromDate = fromDate;
            vm.toDate = toDate;
            return FixAssetService.searchFixAssetByDate(vm.fromDate, vm.toDate, vm.paging, vm.orderBy)
              .then(function (response) {
                  vm.fixAssets = response.data.Items;
                  vm.paging.totalPages = response.data.TotalPages;
                  vm.paging.totalResults = response.data.TotalResults;
                  vm.searchMessage = vm.fixAssets.length === 0 ? "No Records Found" : "";
                  return vm.fixAssets;
              });
        }

        function pageChanged() {
            return retrieveFixAssets();
        }

        function order(property) {
            vm.orderBy = OrderService.order(vm.orderBy, property);
            return retrieveFixAssets();
        }

        function orderClass(property) {
            return OrderService.orderClass(vm.orderBy, property);
        }

        function editFixAsset(id) {
            $window.location.href = "/FixAsset/Edit/" + id;
        }
        
        function viewFixAsset(fixAssetId) {
            $window.location.href = "/FixAsset/View/" + fixAssetId;
        }

    }

})();
