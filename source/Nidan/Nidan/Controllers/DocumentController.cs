﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Nidan.Business.Interfaces;
using Nidan.Entity.Dto;
using Nidan.Extensions;
using System.IO;
using Nidan.Document.Interfaces;
using Nidan.Models;

namespace Nidan.Controllers
{
    public class DocumentController : BaseController
    {
        private readonly IDocumentService _documentService;
        public DocumentController(INidanBusinessService nidanBusinessService, IDocumentService documentService) : base(nidanBusinessService)
        {
            _documentService = documentService;
        }
        // GET: Document
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult StudentDocument(string studentCode, Paging paging, List<OrderBy> orderBy)
        {
            return this.JsonNet(NidanBusinessService.RetrieveDocuments(UserOrganisationId, e => e.CentreId == UserCentreId && e.StudentCode == studentCode, orderBy, paging));
        }
        [HttpPost]
        public ActionResult List(Paging paging, List<OrderBy> orderBy)
        {
            return this.JsonNet(null);
        }

        public ActionResult Download(Guid id)
        {
            var document = NidanBusinessService.RetrieveDocument(UserOrganisationId, id);
            return File(System.IO.File.ReadAllBytes(document.Location), "application/pdf", document.FileName);
        }

        [HttpPost]
        public ActionResult DocumentTypes()
        {
            return this.JsonNet(NidanBusinessService.RetrieveDocumentTypes(UserOrganisationId));
        }

        [HttpPost]
        public void CreateDocument(DocumentViewModel documentViewModel)
        {
            var studentData =
                NidanBusinessService.RetrieveEnquiries(UserOrganisationId,
                    e => e.CentreId == UserCentreId && e.StudentCode == documentViewModel.StudentCode).ToList().FirstOrDefault();
            _documentService.Create(UserOrganisationId, UserCentreId,
                            documentViewModel.DocumentTypeId, documentViewModel.StudentCode,
                            studentData?.FirstName, "Counselling Document", documentViewModel.Attachment.FileName,
                            documentViewModel.Attachment.InputStream.ToBytes());
        }
    }
}