//
//  ContentView.swift
//  DevRush 1
//
//  Created by Алкександр Степанов on 14.09.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var transformedValue = "Temperature"
    @State private var inputValue = 0.0
    @State private var outputValue = 0.0
    @State private var inputDimention: Dimension = UnitTemperature.celsius
    @State private var outputDimention: Dimension = UnitTemperature.fahrenheit
    @State private var inputUnitOfMeasure = "Celsius"
    @State private var outputUnitOfMeasure = "Farenheit"
    @State private var dimentionArray = []
    @State private var textFieldWidth: CGFloat = 10
    let valueArray = ["Temperature", "Distance", "Time", "Volume"]
    let temperatureValueArray = ["Celsius", "Farenheit", "Kelvin"]
    let distanceValueArray = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
    let timeValueArray = ["Seconds", "Minutes", "Hours"]
    let volumeValueArray = ["Liters", "Mililiters", "Cups", "Pints", "Gallons"]
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Chose Value", selection: $transformedValue){
                        ForEach(valueArray, id: \.self){
                            Text($0)
                        }
                    }
                    
                    Picker("Initial unit of Measure", selection: $inputUnitOfMeasure){
                        ForEach(returnUnitOfMeasureArray(), id: \.self){
                            Text($0)
                        }
                    }
                    
                    Picker("Final unit of Measure", selection: $outputUnitOfMeasure){
                        ForEach(returnUnitOfMeasureArray(), id: \.self){
                            Text($0)
                        }
                    }
                }
                Section("Enter your value"){
                    HStack(spacing: 0){
                        TextField("Enter your value", value: $inputValue, format: .number)
                            .frame(width: textFieldWidth)
//                            .textFieldStyle(.roundedBorder)
                        Text(inputDimention.symbol)
                    }
                }
                Section("Transformed value"){
                    Text(convertAndFormat(inputValue, from: inputDimention, to: outputDimention))
                }
            }
            .navigationTitle("Convert your Value")
        }
        .onChange(of: inputUnitOfMeasure){ _ in
            inputDimention = returnUintOfMeasure(of: inputUnitOfMeasure)
        }
        .onChange(of: outputUnitOfMeasure){ _ in
            outputDimention = returnUintOfMeasure(of: outputUnitOfMeasure)
        }
        .onChange(of: transformedValue){ _ in
        dimentionArray = returnUnitOfMeasureArray()
        }
        .onChange(of: inputValue){ _ in
        whatTextFieldWidth()
        }
    }
    
    func whatTextFieldWidth() {
        textFieldWidth = CGFloat(String(inputValue).count) * 10
    }
    
    func returnUintOfMeasure(of dimension: String) -> Dimension {
        
        switch dimension{
        case "Celsius":
            return UnitTemperature.celsius
        case "Farenheit":
            return UnitTemperature.fahrenheit
        case "Kelvin":
            return UnitTemperature.kelvin
        case "Meters":
            return UnitLength.meters
        case "Kilometers":
            return UnitLength.kilometers
        case "Feet":
            return UnitLength.feet
        case "Yards":
            return UnitLength.yards
        case "Miles":
            return UnitLength.miles
        case "Seconds":
            return UnitDuration.seconds
        case "Minutes":
            return UnitDuration.minutes
        case "Hours":
            return UnitDuration.hours
        case "Liters":
            return UnitVolume.liters
        case "Mililiters":
            return UnitVolume.milliliters
        case "Cups":
            return UnitVolume.cups
        case "Pints":
            return UnitVolume.pints
        case "Gallons":
            return UnitVolume.gallons
        default:
            return UnitTemperature.celsius
        }
    }
    
    func returnUnitOfMeasureArray() -> [String] {
        var unitOfMeasureArray = temperatureValueArray
        switch transformedValue{
        case "Temperature":
            unitOfMeasureArray = temperatureValueArray
            inputUnitOfMeasure = unitOfMeasureArray[0]
            outputUnitOfMeasure = unitOfMeasureArray[0]
        case "Distance":
            unitOfMeasureArray = distanceValueArray
            inputUnitOfMeasure = unitOfMeasureArray[0]
            outputUnitOfMeasure = unitOfMeasureArray[0]

        case "Time":
            unitOfMeasureArray = timeValueArray
            inputUnitOfMeasure = unitOfMeasureArray[0]
            outputUnitOfMeasure = unitOfMeasureArray[0]

        case "Volume":
            unitOfMeasureArray = volumeValueArray
            inputUnitOfMeasure = unitOfMeasureArray[0]
            outputUnitOfMeasure = unitOfMeasureArray[0]

        default:
            unitOfMeasureArray = temperatureValueArray
            inputUnitOfMeasure = unitOfMeasureArray[0]
            outputUnitOfMeasure = unitOfMeasureArray[0]

        }
        return unitOfMeasureArray
    }
    
    func convertAndFormat(_ value: Double, from inputUnit: Dimension, to outputUnit: Dimension) -> String {
        let inputMeasurement = Measurement(value: value, unit: inputUnit)
        let convertedMeasurement = inputMeasurement.converted(to: outputUnit)
        return String(format: "%.2f", convertedMeasurement.value) + " " + convertedMeasurement.unit.symbol
        
    }
}

#Preview {
    ContentView()
}
