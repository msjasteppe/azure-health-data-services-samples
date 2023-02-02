CREATE EXTERNAL TABLE [fhir].[VisionPrescription] (
    [resourceType] NVARCHAR(4000),
    [id] VARCHAR(64),
    [meta.id] NVARCHAR(100),
    [meta.extension] NVARCHAR(MAX),
    [meta.versionId] VARCHAR(64),
    [meta.lastUpdated] VARCHAR(64),
    [meta.source] VARCHAR(256),
    [meta.profile] VARCHAR(MAX),
    [meta.security] VARCHAR(MAX),
    [meta.tag] VARCHAR(MAX),
    [implicitRules] VARCHAR(256),
    [language] NVARCHAR(100),
    [text.id] NVARCHAR(100),
    [text.extension] NVARCHAR(MAX),
    [text.status] NVARCHAR(64),
    [text.div] NVARCHAR(MAX),
    [extension] NVARCHAR(MAX),
    [modifierExtension] NVARCHAR(MAX),
    [identifier] VARCHAR(MAX),
    [status] NVARCHAR(100),
    [created] VARCHAR(64),
    [patient.id] NVARCHAR(100),
    [patient.extension] NVARCHAR(MAX),
    [patient.reference] NVARCHAR(4000),
    [patient.type] VARCHAR(256),
    [patient.identifier.id] NVARCHAR(100),
    [patient.identifier.extension] NVARCHAR(MAX),
    [patient.identifier.use] NVARCHAR(64),
    [patient.identifier.type] NVARCHAR(MAX),
    [patient.identifier.system] VARCHAR(256),
    [patient.identifier.value] NVARCHAR(4000),
    [patient.identifier.period] NVARCHAR(MAX),
    [patient.identifier.assigner] NVARCHAR(MAX),
    [patient.display] NVARCHAR(4000),
    [encounter.id] NVARCHAR(100),
    [encounter.extension] NVARCHAR(MAX),
    [encounter.reference] NVARCHAR(4000),
    [encounter.type] VARCHAR(256),
    [encounter.identifier.id] NVARCHAR(100),
    [encounter.identifier.extension] NVARCHAR(MAX),
    [encounter.identifier.use] NVARCHAR(64),
    [encounter.identifier.type] NVARCHAR(MAX),
    [encounter.identifier.system] VARCHAR(256),
    [encounter.identifier.value] NVARCHAR(4000),
    [encounter.identifier.period] NVARCHAR(MAX),
    [encounter.identifier.assigner] NVARCHAR(MAX),
    [encounter.display] NVARCHAR(4000),
    [dateWritten] VARCHAR(64),
    [prescriber.id] NVARCHAR(100),
    [prescriber.extension] NVARCHAR(MAX),
    [prescriber.reference] NVARCHAR(4000),
    [prescriber.type] VARCHAR(256),
    [prescriber.identifier.id] NVARCHAR(100),
    [prescriber.identifier.extension] NVARCHAR(MAX),
    [prescriber.identifier.use] NVARCHAR(64),
    [prescriber.identifier.type] NVARCHAR(MAX),
    [prescriber.identifier.system] VARCHAR(256),
    [prescriber.identifier.value] NVARCHAR(4000),
    [prescriber.identifier.period] NVARCHAR(MAX),
    [prescriber.identifier.assigner] NVARCHAR(MAX),
    [prescriber.display] NVARCHAR(4000),
    [lensSpecification] VARCHAR(MAX),
) WITH (
    LOCATION='/VisionPrescription/**',
    DATA_SOURCE = ParquetSource,
    FILE_FORMAT = ParquetFormat
);

GO

CREATE VIEW fhir.VisionPrescriptionIdentifier AS
SELECT
    [id],
    [identifier.JSON],
    [identifier.id],
    [identifier.extension],
    [identifier.use],
    [identifier.type.id],
    [identifier.type.extension],
    [identifier.type.coding],
    [identifier.type.text],
    [identifier.system],
    [identifier.value],
    [identifier.period.id],
    [identifier.period.extension],
    [identifier.period.start],
    [identifier.period.end],
    [identifier.assigner.id],
    [identifier.assigner.extension],
    [identifier.assigner.reference],
    [identifier.assigner.type],
    [identifier.assigner.identifier],
    [identifier.assigner.display]
FROM openrowset (
        BULK 'VisionPrescription/**',
        DATA_SOURCE = 'ParquetSource',
        FORMAT = 'PARQUET'
    ) WITH (
        [id]   VARCHAR(64),
       [identifier.JSON]  VARCHAR(MAX) '$.identifier'
    ) AS rowset
    CROSS APPLY openjson (rowset.[identifier.JSON]) with (
        [identifier.id]                NVARCHAR(100)       '$.id',
        [identifier.extension]         NVARCHAR(MAX)       '$.extension',
        [identifier.use]               NVARCHAR(64)        '$.use',
        [identifier.type.id]           NVARCHAR(100)       '$.type.id',
        [identifier.type.extension]    NVARCHAR(MAX)       '$.type.extension',
        [identifier.type.coding]       NVARCHAR(MAX)       '$.type.coding',
        [identifier.type.text]         NVARCHAR(4000)      '$.type.text',
        [identifier.system]            VARCHAR(256)        '$.system',
        [identifier.value]             NVARCHAR(4000)      '$.value',
        [identifier.period.id]         NVARCHAR(100)       '$.period.id',
        [identifier.period.extension]  NVARCHAR(MAX)       '$.period.extension',
        [identifier.period.start]      VARCHAR(64)         '$.period.start',
        [identifier.period.end]        VARCHAR(64)         '$.period.end',
        [identifier.assigner.id]       NVARCHAR(100)       '$.assigner.id',
        [identifier.assigner.extension] NVARCHAR(MAX)       '$.assigner.extension',
        [identifier.assigner.reference] NVARCHAR(4000)      '$.assigner.reference',
        [identifier.assigner.type]     VARCHAR(256)        '$.assigner.type',
        [identifier.assigner.identifier] NVARCHAR(MAX)       '$.assigner.identifier',
        [identifier.assigner.display]  NVARCHAR(4000)      '$.assigner.display'
    ) j

GO

CREATE VIEW fhir.VisionPrescriptionLensSpecification AS
SELECT
    [id],
    [lensSpecification.JSON],
    [lensSpecification.id],
    [lensSpecification.extension],
    [lensSpecification.modifierExtension],
    [lensSpecification.product.id],
    [lensSpecification.product.extension],
    [lensSpecification.product.coding],
    [lensSpecification.product.text],
    [lensSpecification.eye],
    [lensSpecification.sphere],
    [lensSpecification.cylinder],
    [lensSpecification.axis],
    [lensSpecification.prism],
    [lensSpecification.add],
    [lensSpecification.power],
    [lensSpecification.backCurve],
    [lensSpecification.diameter],
    [lensSpecification.duration.id],
    [lensSpecification.duration.extension],
    [lensSpecification.duration.value],
    [lensSpecification.duration.comparator],
    [lensSpecification.duration.unit],
    [lensSpecification.duration.system],
    [lensSpecification.duration.code],
    [lensSpecification.color],
    [lensSpecification.brand],
    [lensSpecification.note]
FROM openrowset (
        BULK 'VisionPrescription/**',
        DATA_SOURCE = 'ParquetSource',
        FORMAT = 'PARQUET'
    ) WITH (
        [id]   VARCHAR(64),
       [lensSpecification.JSON]  VARCHAR(MAX) '$.lensSpecification'
    ) AS rowset
    CROSS APPLY openjson (rowset.[lensSpecification.JSON]) with (
        [lensSpecification.id]         NVARCHAR(100)       '$.id',
        [lensSpecification.extension]  NVARCHAR(MAX)       '$.extension',
        [lensSpecification.modifierExtension] NVARCHAR(MAX)       '$.modifierExtension',
        [lensSpecification.product.id] NVARCHAR(100)       '$.product.id',
        [lensSpecification.product.extension] NVARCHAR(MAX)       '$.product.extension',
        [lensSpecification.product.coding] NVARCHAR(MAX)       '$.product.coding',
        [lensSpecification.product.text] NVARCHAR(4000)      '$.product.text',
        [lensSpecification.eye]        NVARCHAR(64)        '$.eye',
        [lensSpecification.sphere]     float               '$.sphere',
        [lensSpecification.cylinder]   float               '$.cylinder',
        [lensSpecification.axis]       bigint              '$.axis',
        [lensSpecification.prism]      NVARCHAR(MAX)       '$.prism' AS JSON,
        [lensSpecification.add]        float               '$.add',
        [lensSpecification.power]      float               '$.power',
        [lensSpecification.backCurve]  float               '$.backCurve',
        [lensSpecification.diameter]   float               '$.diameter',
        [lensSpecification.duration.id] NVARCHAR(100)       '$.duration.id',
        [lensSpecification.duration.extension] NVARCHAR(MAX)       '$.duration.extension',
        [lensSpecification.duration.value] float               '$.duration.value',
        [lensSpecification.duration.comparator] NVARCHAR(64)        '$.duration.comparator',
        [lensSpecification.duration.unit] NVARCHAR(100)       '$.duration.unit',
        [lensSpecification.duration.system] VARCHAR(256)        '$.duration.system',
        [lensSpecification.duration.code] NVARCHAR(4000)      '$.duration.code',
        [lensSpecification.color]      NVARCHAR(100)       '$.color',
        [lensSpecification.brand]      NVARCHAR(500)       '$.brand',
        [lensSpecification.note]       NVARCHAR(MAX)       '$.note' AS JSON
    ) j