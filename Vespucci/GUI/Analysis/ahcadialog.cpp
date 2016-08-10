/*******************************************************************************
    Copyright (C) 2014-2016 Wright State University - All Rights Reserved
    Daniel P. Foose - Maintainer/Lead Developer

    This file is part of Vespucci.

    Vespucci is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Vespucci is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Vespucci.  If not, see <http://www.gnu.org/licenses/>.
*******************************************************************************/
#include "ahcadialog.h"
#include "ui_ahcadialog.h"
#include "Data/Analysis/multianalyzer.h"

AHCADialog::AHCADialog(QWidget *parent, QSharedPointer<VespucciWorkspace> ws, const QString &dataset_key) :
    QDialog(parent),
    ui(new Ui::AHCADialog)
{
    ui->setupUi(this);
    workspace_ = ws;
    dataset_ = workspace_->GetDataset(dataset_key);
}

AHCADialog::AHCADialog(QSharedPointer<VespucciWorkspace> ws, const QStringList &dataset_keys) :
    QDialog(ws->main_window()),
    ui(new Ui::AHCADialog)
{
    ui->setupUi(this);
    workspace_ = ws;
    dataset_keys_ = dataset_keys;
}

AHCADialog::~AHCADialog()
{
    delete ui;
}

void AHCADialog::on_buttonBox_accepted()
{
    QString name = ui->nameLineEdit->text().toLower();
    QString metric = ui->metricComboBox->currentText().toLower();
    QString linkage = ui->linkageComboBox->currentText().toLower();
    metric.remove(" ");
    linkage.remove(" ");
    if (!dataset_keys_.isEmpty()){
        try{
            MultiAnalyzer analyzer(workspace_, dataset_keys_);
            analyzer.AgglomerativeClustering(name, metric, linkage);
        }catch(exception e){
            workspace_->main_window()->DisplayExceptionWarning(e);
        }
        close();
        return;
    }
    else if (!dataset_.isNull()){
        try{
            dataset_->AgglomerativeClustering(name, linkage, metric);
        }catch(exception e){
            workspace_->main_window()->DisplayExceptionWarning(e);
        }

        close();
        return;
    }
    else{
        close();
        return;
    }
}

void AHCADialog::on_linkageComboBox_currentTextChanged(const QString &arg1)
{
    ui->metricComboBox->clear();
    QStringList metric_list;
    if (arg1 == "Ward"){
        metric_list = QStringList({"Squared Euclidean"});
    }
    else{
        metric_list = QStringList({"Squared Euclidean",
                                  "Euclidean",
                                  "Manhattan",
                                  "Chebyshev",
                                  "Cosine",
                                  "Correlation"});
    }
    ui->linkageComboBox->addItems(metric_list);
}
